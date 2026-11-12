self:
{ config, lib, pkgs, ... }:

let
  cfg = config.services.blvm;
  inherit (lib) mkEnableOption mkOption mkIf types optionals optional escapeShellArgs;
  defaultP2pPort = {
    mainnet = 8333;
    testnet = 18333;
    testnet4 = 48333;
    signet = 38333;
    regtest = 18444;
  }.${cfg.network};
in
{
  options.services.blvm = {
    enable = mkEnableOption "the Bitcoin Commons BLVM node";

    package = mkOption {
      type = types.package;
      default = self.packages.${pkgs.stdenv.hostPlatform.system}.blvm;
      defaultText = lib.literalExpression "blvm.packages.\${system}.blvm";
      description = "blvm package to run.";
    };

    network = mkOption {
      type = types.enum [ "mainnet" "testnet" "testnet4" "signet" "regtest" ];
      default = "mainnet";
      description = "Bitcoin network.";
    };

    dataDir = mkOption {
      type = types.path;
      default = "/var/lib/blvm";
      description = "Data directory (chain state, indexes).";
    };

    configFile = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "Optional TOML or JSON config passed with --config. Keep it in the Nix store so it is versioned with the rest of the system.";
    };

    listenAddress = mkOption {
      type = types.nullOr types.str;
      default = null;
      example = "0.0.0.0:8333";
      description = "P2P listen address. Null uses the network default.";
    };

    rpcAddress = mkOption {
      type = types.nullOr types.str;
      default = null;
      example = "127.0.0.1:8332";
      description = "RPC address. Null uses the network default. Keep it on loopback unless something else on the host must reach it.";
    };

    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = "Open the P2P port. RPC is never opened by this module.";
    };

    extraArgs = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Extra command-line arguments for blvm.";
    };

    user = mkOption { type = types.str; default = "blvm"; description = "Service user."; };
    group = mkOption { type = types.str; default = "blvm"; description = "Service group."; };
  };

  config = mkIf cfg.enable {
    users.users = mkIf (cfg.user == "blvm") {
      blvm = { isSystemUser = true; group = cfg.group; home = cfg.dataDir; };
    };
    users.groups = mkIf (cfg.group == "blvm") { blvm = { }; };

    systemd.tmpfiles.rules = [ "d '${cfg.dataDir}' 0750 ${cfg.user} ${cfg.group} - -" ];

    systemd.services.blvm = {
      description = "Bitcoin Commons BLVM node";
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      serviceConfig = {
        ExecStart = escapeShellArgs ([
          (lib.getExe cfg.package)
          "--network" cfg.network
          "--data-dir" cfg.dataDir
        ]
        ++ optionals (cfg.configFile != null) [ "--config" "${cfg.configFile}" ]
        ++ optionals (cfg.listenAddress != null) [ "--listen-addr" cfg.listenAddress ]
        ++ optionals (cfg.rpcAddress != null) [ "--rpc-addr" cfg.rpcAddress ]
        ++ [ "--no-auto-migrate" ]
        ++ cfg.extraArgs);
        WorkingDirectory = cfg.dataDir;
        User = cfg.user;
        Group = cfg.group;
        Restart = "on-failure";
        RestartSec = 10;
        TimeoutStopSec = 600;

        # Hardening: the node needs its data dir and the network, nothing else.
        ReadWritePaths = [ cfg.dataDir ];
        ProtectSystem = "strict";
        ProtectHome = true;
        PrivateTmp = true;
        PrivateDevices = true;
        NoNewPrivileges = true;
        ProtectKernelTunables = true;
        ProtectKernelModules = true;
        ProtectKernelLogs = true;
        ProtectControlGroups = true;
        ProtectClock = true;
        ProtectHostname = true;
        RestrictSUIDSGID = true;
        RestrictRealtime = true;
        RestrictNamespaces = true;
        LockPersonality = true;
        RemoveIPC = true;
        CapabilityBoundingSet = "";
        RestrictAddressFamilies = [ "AF_UNIX" "AF_INET" "AF_INET6" "AF_NETLINK" ];
        SystemCallArchitectures = "native";
        UMask = "0027";
      };
    };

    networking.firewall.allowedTCPPorts = optional cfg.openFirewall (
      if cfg.listenAddress != null
      then lib.toInt (lib.last (lib.splitString ":" cfg.listenAddress))
      else defaultP2pPort
    );
  };
}

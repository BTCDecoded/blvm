{ config, lib, pkgs, ... }:

let
  cfg = config.services.blvm;
  configFile = pkgs.writeText "blvm.toml" ''
    [storage]
    database_backend = "heed3"
    data_dir = "${cfg.dataDir}"
  '';
in
{
  options.services.blvm = {
    enable = lib.mkEnableOption "BLVM node (heed3)";

    package = lib.mkOption {
      type = lib.types.package;
      description = ''
        heed3 blvm package from this flake (`packages.<system>.default`).
        The module does not pull a RocksDB build.
      '';
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = "blvm";
      description = "System user the node runs as.";
    };

    group = lib.mkOption {
      type = lib.types.str;
      default = "blvm";
      description = "System group the node runs as.";
    };

    dataDir = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/blvm";
      description = "Chain data directory. StateDirectory creates /var/lib/blvm.";
    };

    network = lib.mkOption {
      type = lib.types.enum [ "mainnet" "testnet" "signet" "regtest" ];
      default = "mainnet";
      description = "Passed as --network.";
    };

    listenAddress = lib.mkOption {
      type = lib.types.str;
      default = "0.0.0.0:8333";
      description = "P2P listen address, passed as --listen-addr.";
    };

    rpc = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = ''
          Bind the RPC listener with --rpc-addr. When false, ExecStart omits
          that flag. Ready is the RPC port binding, not sync.
        '';
      };

      address = lib.mkOption {
        type = lib.types.str;
        default = "127.0.0.1:8332";
        example = "127.0.0.1:18443";
        description = ''
          RPC bind address passed as --rpc-addr.
        '';
      };
    };

    extraArgs = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Extra arguments appended to ExecStart.";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.user} = {
      isSystemUser = true;
      group = cfg.group;
    };
    users.groups.${cfg.group} = { };

    systemd.services.blvm = {
      description = "BLVM node";
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" "time-sync.target" ];
      wants = [ "network-online.target" ];
      environment.NO_COLOR = "1";
      serviceConfig = {
        Type = "notify";
        NotifyAccess = "main";
        User = cfg.user;
        Group = cfg.group;
        StateDirectory = "blvm";
        WorkingDirectory = cfg.dataDir;
        ExecStart = lib.concatStringsSep " " ([
          "${cfg.package}/bin/blvm"
          "--config ${configFile}"
          "--data-dir ${cfg.dataDir}"
          "--network ${cfg.network}"
          "--listen-addr ${cfg.listenAddress}"
        ] ++ lib.optionals cfg.rpc.enable [
          "--rpc-addr ${cfg.rpc.address}"
        ] ++ cfg.extraArgs);
        KillSignal = "SIGTERM";
        TimeoutStartSec = 61;
        TimeoutStopSec = 240;
        WatchdogSec = 240;
        Restart = "on-failure";
        ProtectSystem = "full";
        NoNewPrivileges = true;
        PrivateTmp = true;
      };
    };
  };
}

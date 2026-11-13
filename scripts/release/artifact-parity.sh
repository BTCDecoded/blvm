#!/bin/sh
# Compare a source build, a prebuilt binary, and a Docker image on one smoke.
# The smoke is: start regtest with the minimal-hardened profile, call
# getblockcount, and stop. Missing artifacts exit 2. A mismatch exits 1.
# Exit 0 is a completed comparison.
set -eu
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
PROFILE="${BLVM_PROFILE:-$ROOT/../blvm-node/config/minimal-hardened.toml}"

compare_counts() {
  if [ "$1" = "$2" ] && [ "$2" = "$3" ]; then
    return 0
  fi
  return 1
}

count_one() {
  kind=$1
  artifact=$2
  port=$3
  python3 - "$kind" "$artifact" "$port" "$PROFILE" <<'PY'
import http.client, json, os, signal, socket, subprocess, sys, tempfile, time, urllib.parse

kind, artifact, port_s, profile = sys.argv[1:5]
port = int(port_s)
if port == 18443 or port + 1 == 18443:
    sys.stderr.write("parity: port 18443 is reserved on this host\n")
    sys.exit(1)

def free(candidate):
    probe = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    try:
        probe.bind(("127.0.0.1", candidate))
    except OSError:
        return False
    finally:
        probe.close()
    return True

if not free(port) or not free(port + 1):
    sys.stderr.write(f"parity: 127.0.0.1:{port} is not free\n")
    sys.exit(1)

token = "rpc-token-" + os.urandom(16).hex()
work = tempfile.mkdtemp(prefix="blvm-parity-")
data = os.path.join(work, "data")
os.mkdir(data)
text = open(profile).read()
text = text.replace('protocol_version = "mainnet"', 'protocol_version = "regtest"', 1)
text = text.replace("required = true", 'required = true\ntokens = ["' + token + '"]', 1)
text = text.replace('listen_addr = "127.0.0.1:8333"', f'listen_addr = "127.0.0.1:{port + 1}"', 1)
text = text.replace('rpc_addr = "127.0.0.1:8332"', f'rpc_addr = "127.0.0.1:{port}"', 1)
config = os.path.join(work, "blvm.toml")
with open(config, "w") as handle:
    handle.write(text)
os.chmod(config, 0o600)
log_path = os.path.join(work, "node.log")
log = open(log_path, "ab")
if kind == "bin":
    command = [
        artifact, "--network", "regtest", "--data-dir", data,
        "--config", config, "--noassumevalid",
    ]
elif kind == "docker":
    command = [
        "docker", "run", "--rm", "--network", "host",
        "-v", f"{data}:/data", "-v", f"{work}:/cfg:ro",
        artifact, "--network", "regtest", "--data-dir", "/data",
        "--config", "/cfg/blvm.toml", "--noassumevalid",
    ]
else:
    sys.stderr.write(f"parity: unknown artifact kind {kind}\n")
    sys.exit(1)
process = subprocess.Popen(command, stdout=log, stderr=subprocess.STDOUT)
body = json.dumps(
    {"jsonrpc": "2.0", "id": 1, "method": "getblockcount", "params": []}
).encode()
headers = {"content-type": "application/json", "authorization": "Bearer " + token}
deadline = time.time() + 90
connection = None
last = "rpc did not answer"
count = None
try:
    while time.time() < deadline:
        if process.poll() is not None:
            last = f"process exited {process.returncode} log={log_path}"
            break
        try:
            if connection is None:
                connection = http.client.HTTPConnection("127.0.0.1", port, timeout=10)
            connection.request("POST", "/", body=body, headers=headers)
            response = connection.getresponse()
            payload = json.loads(response.read().decode())
            error = payload.get("error")
            if error and "not initialized" in str(error.get("message", "")):
                last = "chain is not initialized"
                time.sleep(0.5)
                continue
            if error:
                last = "rpc error"
                break
            result = payload.get("result")
            if isinstance(result, int):
                count = result
                break
            if isinstance(result, dict) and isinstance(result.get("blocks"), int):
                count = result["blocks"]
                break
            last = "getblockcount result was not a count"
            break
        except Exception as err:
            last = err.__class__.__name__
            if connection is not None:
                connection.close()
            connection = None
            time.sleep(0.5)
finally:
    if process.poll() is None:
        process.send_signal(signal.SIGTERM)
        try:
            process.wait(timeout=10)
        except subprocess.TimeoutExpired:
            process.kill()
            process.wait(timeout=10)
    log.close()
if count is None:
    sys.stderr.write(f"parity: {kind} did not return getblockcount ({last}) log={log_path}\n")
    sys.exit(1)
sys.stdout.write(f"{count}\n")
PY
}

if [ "${1:-}" = "--self-test" ]; then
  set +e
  output=$(env -u BLVM_SOURCE_BIN -u BLVM_PREBUILT_BIN -u BLVM_DOCKER_IMAGE "$0")
  status=$?
  set -e
  if [ "$status" -ne 2 ]; then
    echo "parity self-test: unset names exited $status"
    exit 1
  fi
  compare_counts 0 0 0
  if compare_counts 0 1 0; then
    echo "parity self-test: a mismatch compared equal"
    exit 1
  fi
  case "$output" in
    *Exit\ 2*) ;;
    *) echo "parity self-test: missing-artifact message was not printed"; exit 1 ;;
  esac
  echo "parity self-test passed"
  echo "gate: source, prebuilt, and docker getblockcount must match"
  exit 0
fi

if [ "${1:-}" = "--count" ]; then
  count_one bin "$2" "${3:-39261}"
  exit 0
fi

echo "artifact parity smoke"
echo "profile=$PROFILE"
echo "source_binary=${BLVM_SOURCE_BIN:-unset}"
echo "prebuilt_binary=${BLVM_PREBUILT_BIN:-unset}"
echo "docker_image=${BLVM_DOCKER_IMAGE:-unset}"
missing=0
for item in "${BLVM_SOURCE_BIN:-}" "${BLVM_PREBUILT_BIN:-}" "${BLVM_DOCKER_IMAGE:-}"; do
  if [ -z "$item" ]; then
    missing=1
  fi
done
if [ "$missing" -ne 0 ]; then
  echo "parity: source, prebuilt, and docker image are not all present. Exit 2."
  exit 2
fi
source_real=$(readlink -f "$BLVM_SOURCE_BIN")
prebuilt_real=$(readlink -f "$BLVM_PREBUILT_BIN")
if [ "$source_real" = "$prebuilt_real" ]; then
  echo "parity: source and prebuilt resolve to the same file. Exit 2."
  exit 2
fi

source_count=$(count_one bin "$BLVM_SOURCE_BIN" 39261)
prebuilt_count=$(count_one bin "$BLVM_PREBUILT_BIN" 39271)
docker_count=$(count_one docker "$BLVM_DOCKER_IMAGE" 39281)
echo "getblockcount source=$source_count prebuilt=$prebuilt_count docker=$docker_count"
if compare_counts "$source_count" "$prebuilt_count" "$docker_count"; then
  echo "parity: getblockcount matches. Exit 0."
  exit 0
fi
echo "parity: getblockcount mismatch. Exit 1."
exit 1

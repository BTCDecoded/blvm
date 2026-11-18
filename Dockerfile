# syntax=docker/dockerfile:1
# Multi-stage image for GHCR; build context must be crates.io-clean (no [patch.crates-io] — CI strips before build).
FROM rust:1.88-bookworm AS builder
WORKDIR /app
# librocksdb-sys uses bindgen → libclang; RocksDB itself needs cmake + a C++ toolchain.
# Native compression libs match typical Debian rocksdb builds (see blvm-node CI).
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential cmake pkg-config libssl-dev \
    clang libclang-dev \
    liblz4-dev libzstd-dev libsnappy-dev \
    && rm -rf /var/lib/apt/lists/*

COPY . .
RUN cargo build --locked --release

FROM debian:bookworm-slim
# uid 61100 is outside Debian's system range so a rebuild does not pick a new id.
# The operator bind-mounts a directory owned by this uid. There is no VOLUME.
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates libssl3 \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd --gid 61100 blvm \
    && useradd --uid 61100 --gid 61100 --no-create-home --shell /usr/sbin/nologin blvm \
    && mkdir -p /var/lib/blvm \
    && chown 61100:61100 /var/lib/blvm
COPY --from=builder /app/target/release/blvm /usr/local/bin/blvm
COPY contrib/init/docker-entrypoint.sh /usr/local/bin/blvm-entrypoint
RUN chmod 755 /usr/local/bin/blvm-entrypoint
ENV BLVM_DATA_DIR=/var/lib/blvm \
    NO_COLOR=1
STOPSIGNAL SIGTERM
WORKDIR /var/lib/blvm
USER 61100:61100
ENTRYPOINT ["/usr/local/bin/blvm-entrypoint"]
CMD ["start"]
# 300s is a start grace, not a measured store-open time. Failures during it do not count.
# `blvm health` calls getblockchaininfo, which stays success during initial sync.
HEALTHCHECK --interval=30s --timeout=15s --start-period=300s --retries=3 \
    CMD ["/usr/local/bin/blvm-entrypoint", "health"]

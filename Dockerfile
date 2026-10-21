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

# Release images must not link CUDA (matches the release binaries).
ENV BLVM_SECP256K1_NO_GPU=1
# CI passes the release version; the build fails if the binary reports anything else.
ARG BLVM_VERSION=
COPY . .
RUN cargo build --locked --release \
    && reported="$(./target/release/blvm version | sed -n 1p)" \
    && echo "built: ${reported}" \
    && if [ -n "${BLVM_VERSION}" ] && [ "${reported}" != "blvm ${BLVM_VERSION}" ]; then \
         echo "error: image binary reports '${reported}', release is ${BLVM_VERSION}" >&2; exit 1; \
       fi

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates libssl3 \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -r -m -s /usr/sbin/nologin blvm
COPY --from=builder /app/target/release/blvm /usr/local/bin/blvm
USER blvm
ENTRYPOINT ["/usr/local/bin/blvm"]
CMD ["version"]

# syntax=docker/dockerfile:1
# Multi-stage image for GHCR; build context must be crates.io-clean (no [patch.crates-io] — CI strips before build).
FROM rust:1.88-bookworm AS builder
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends \
    pkg-config libssl-dev \
    && rm -rf /var/lib/apt/lists/*

COPY . .
RUN cargo build --locked --release

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates libssl3 \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -r -m -s /usr/sbin/nologin blvm
COPY --from=builder /app/target/release/blvm /usr/local/bin/blvm
USER blvm
ENTRYPOINT ["/usr/local/bin/blvm"]
CMD ["version"]

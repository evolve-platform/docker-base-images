ARG BASE_IMAGE=node:24-bookworm-slim

FROM $BASE_IMAGE

LABEL org.opencontainers.image.source="https://github.com/labdigital-evolve/docker-base-images/"
LABEL org.opencontainers.image.description="Custom Node.js base image with pnpm support"

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends ca-certificates dumb-init curl unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN npm install -g corepack@latest && corepack enable pnpm

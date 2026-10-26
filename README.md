# Evolve docker base images

Custom Node.js base images with `pnpm` (via corepack), `dumb-init`, `curl`, and `unzip` pre-installed. Published as multi-arch (`amd64`/`arm64`) images to GitHub Container Registry.

## Available tags

| Tag | Node.js version | Base image | Status |
|-----|----------------|------------|--------|
| `26` | Latest Node 26.x | Debian Trixie slim | Current |
| `26.3` | 26.3.x | Debian Trixie slim | Current |
| `24` | Latest Node 24.x | Debian Bookworm slim | Active LTS |
| `24.15` | 24.15.x | Debian Bookworm slim | Active LTS |
| `24.14` | 24.14.x | Debian Bookworm slim | Active LTS |
| `24.13` | 24.13.x | Debian Bookworm slim | Active LTS |
| `22` | Latest Node 22.x | Debian Bookworm slim | Maintenance LTS |
| `22.22` | 22.22.x | Debian Bookworm slim | Maintenance LTS |
| `22.14` | 22.14.x | Debian Bookworm slim | Maintenance LTS |

## Hardened (minimal) tags

Built on [Docker Hardened Images](https://hub.docker.com/hardened-images/catalog/dhi/node) (Debian 13).

| Tag | Use | Contents |
|-----|-----|----------|
| `26-min-dev` | Build stage | Runs as root. Shell, apt, npm, `pnpm`, `dumb-init`, `curl`, `unzip`. |
| `26-min` | Runtime stage | Runs as `node` (uid 1000). No shell or package manager. Adds `dumb-init` only. |

The runtime image has no shell. Use exec-form `ENTRYPOINT`/`CMD`.

```dockerfile
FROM ghcr.io/evolve-platform/node:26-min-dev AS build
WORKDIR /app
COPY . .
RUN pnpm install --frozen-lockfile && pnpm build

FROM ghcr.io/evolve-platform/node:26-min
COPY --from=build --chown=1000:1000 /app/dist /app/dist
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["node", "dist/index.js"]
```

## Usage

```dockerfile
FROM ghcr.io/evolve-platform/node:26.3
```

## Authentication

If you want to run these images on your laptop, use the GitHub CLI with a Docker login helper:

1. Install the GitHub CLI: `brew install gh`
2. Follow the steps at https://gist.github.com/mislav/e154d707db230dc882d7194ec85d79f6
3. If needed, add package scopes: `gh auth refresh --scopes=read:packages,write:packages`

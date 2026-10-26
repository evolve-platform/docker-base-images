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

## Hardened (minimal) tags — preview

> [!WARNING]
> These tags are a preview. Contents and tags may change without notice. Do not use them for production workloads yet.

Built on [Docker Hardened Images](https://hub.docker.com/hardened-images/catalog/dhi/node) (Debian 13). Multi-arch (`amd64`/`arm64`).

| Tag | Use | Contents | Status |
|-----|-----|----------|--------|
| `26-min-dev` | Build stage | Runs as root. Shell, apt, npm, `pnpm`, `dumb-init`, `curl`, `unzip`. | Preview |
| `26-min` | Runtime stage | Runs as `node` (uid 1000). No shell or package manager. Adds `dumb-init` only. | Preview |

### Usage

Use `26-min-dev` to install and build. Copy only the build output into `26-min`.

> [!IMPORTANT]
> `26-min` differs from the other tags:
> - It runs as `node` (uid 1000), not root. Copy files in with `--chown=1000:1000`, or the app cannot write to them.
> - It has no shell. `RUN` steps fail, and shell-form `CMD`/`ENTRYPOINT` does not work. Use exec form (JSON array).
> - The working directory is `/app`.
> - It has no package manager. Install all dependencies in the `26-min-dev` stage.

```dockerfile
FROM ghcr.io/evolve-platform/node:26-min-dev AS build
WORKDIR /app
COPY . .
RUN pnpm install --frozen-lockfile && pnpm build && pnpm prune --prod

FROM ghcr.io/evolve-platform/node:26-min
COPY --from=build --chown=1000:1000 /app/node_modules /app/node_modules
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

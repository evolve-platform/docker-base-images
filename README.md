# Evolve docker base images

Custom Node.js base images with `pnpm` (via corepack), `dumb-init`, `curl`, and `unzip` pre-installed. Published as multi-arch (`amd64`/`arm64`) images to GitHub Container Registry.

## Available tags

| Tag | Node.js version | Base image | Status |
|-----|----------------|------------|--------|
| `26` | Latest Node 26.x | Debian Trixie slim | Current |
| `26.12` | 26.12.x | Debian Trixie slim | Current |
| `26.3` | 26.3.x | Debian Trixie slim | Frozen |
| `24` | Latest Node 24.x | Debian Bookworm slim | Active LTS |
| `24.22` | 24.22.x | Debian Bookworm slim | Active LTS |
| `24.15` | 24.15.x | Debian Bookworm slim | Frozen |
| `24.14` | 24.14.x | Debian Bookworm slim | Frozen |
| `24.13` | 24.13.x | Debian Bookworm slim | Frozen |
| `22` | Latest Node 22.x | Debian Bookworm slim | Maintenance LTS |
| `22.23` | 22.23.x | Debian Bookworm slim | Maintenance LTS |
| `22.22` | 22.22.x | Debian Bookworm slim | Frozen |
| `22.14` | 22.14.x | Debian Bookworm slim | Frozen |

Node.js ships security fixes only on the newest minor of each release line, so a minor tag stops receiving them once a newer minor is out. A frozen tag still rebuilds weekly for Debian updates, but its Node.js version never gets another patch: move to the floating major tag or the newest minor.

## Usage

```dockerfile
FROM ghcr.io/evolve-platform/node:26
```

## Authentication

If you want to run these images on your laptop, use the GitHub CLI with a Docker login helper:

1. Install the GitHub CLI: `brew install gh`
2. Follow the steps at https://gist.github.com/mislav/e154d707db230dc882d7194ec85d79f6
3. If needed, add package scopes: `gh auth refresh --scopes=read:packages,write:packages`

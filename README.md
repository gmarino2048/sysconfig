# sysconfig

Personal [nix-darwin](https://github.com/nix-darwin/nix-darwin) + [home-manager](https://github.com/nix-community/home-manager) configuration, running on [Determinate Nix](https://determinate.systems/). Managed with [jujutsu](https://jj-vcs.github.io/jj/).

## Layout

| Path | What |
| --- | --- |
| `flake.nix` | Inputs (all unstable) + `darwinConfigurations` + dev-shell. Each machine's theme is set here. |
| `darwin/` | macOS systems. `default.nix` is common; `hosts/<name>.nix` holds per-host diffs. |
| `nixos/` | Future Linux systems. |
| `home/` | home-manager modules (one program per file); raw config in `home/dotfiles/`. |
| `themes/` | Theme palettes (`forest` = Everforest, `ocean` = Nord). |

## Machines

| Host | System | Theme |
| --- | --- | --- |
| `pegasus` | `aarch64-darwin` | `forest` |

## Rebuild

```sh
darwin-rebuild switch --flake .#pegasus
```

First-time activation (before `darwin-rebuild` exists on PATH):

```sh
sudo nix run nix-darwin -- switch --flake .#pegasus
```

## Identities

SSH (`~/.ssh/github-auth-key`) and the GPG signing key are generated on the machine and live outside this repo. Add the public halves to GitHub.

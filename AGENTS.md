# Repository Guidelines

## Overview
This repository **is** the live `~/.config` tree. Changes apply immediately to the user's niri-based Linux desktop. Keep edits minimal, reviewable, and safe.

## Project Structure
- `niri/`: window manager config (KDL). Includes `monitors.kdl`.
- `waybar/`, `rofi/`: status bar and launcher UI.
- `wallust/`: active theme/palette engine (`wallust.toml` + `templates/`). Generates color configs for waybar, rofi, kitty, alacritty, gtk, zathura, mako, vscode, telegram, zed, opencode, sevens-shell.
- `matugen/`: alternative palette generator (mostly legacy; wallust is primary).
- `fish/`: shell config (`config.fish`, `conf.d/`).
- `nvim/`: Neovim (LazyVim) config. See `nvim/AGENTS.md` for detailed plugin/Lua guidance.
- `scripts/`: helper utilities. Shared helpers live in `scripts/lib/common.sh`.
- `wallpapers/`: git submodule containing wallpaper assets.

## Critical Gotchas

### `.gitignore` is aggressive
Many application directories are ignored by default (IDEs, browsers, media apps, system utils, DE frameworks, electron apps, `*.env`, `temp.md`).
- Before adding a new tracked app config, verify the directory name is **not** blocked in `.gitignore`.
- If it is blocked, use `git add -f <path>` and consider updating `.gitignore` with a negation pattern if the dir should stay tracked.
- Existing untracked dirs on disk (e.g. `google-chrome/`, `spotify/`) are intentionally ignored.

### Git submodule
`wallpapers/` is a submodule. After clone or when wallpapers are missing:
```bash
git submodule update --init --recursive
```

### Theming pipeline
- `wallust.toml` maps templates in `wallust/templates/` to absolute output paths. Editing a template changes colors for all linked apps on the next `wallust` run.
- `scripts/theme-sync.sh` orchestrates the full theme switch: detects wallpaper directory → sets GTK/icon themes → runs `wallust` → updates `niri/config.kdl` colors → writes `zellij` theme (RGB integers, not hex) → reloads `kitty`, and `vicinae`.
- If you change `theme-sync.sh`, validate with `bash -n scripts/theme-sync.sh`.

## Build, Test, and Development Commands
- `git submodule update --init --recursive`: fetch/update `wallpapers/`.
- `bash -n scripts/*.sh`: quick syntax check for scripts (optionally `shellcheck scripts/*.sh` if installed).
- `stylua .`: format Lua files (uses `nvim/stylua.toml` — 2-space indent, 120 cols).
- `nvim --headless "+checkhealth" +qa`: headless Neovim sanity check.
- Plugin/LSP health: open `nvim`, run `:checkhealth` and `:LazyHealth`.

## Coding Style & Naming Conventions
- Keep configs idiomatic to the target tool (don't "normalize" unrelated formatting).
- Shell: prefer bash with `set -euo pipefail` for non-trivial scripts; keep CLI flags explicit. Source `scripts/lib/common.sh` for shared logging/validation utilities.
- Lua (Neovim): see `nvim/AGENTS.md` and `nvim/stylua.toml`.
- Naming: keep paths aligned with upstream app names (e.g. `niri/`, `nvim/`, `waybar/`); avoid introducing new top-level dirs without a clear owner.

## Security & Configuration Tips
- Do **not** commit secrets (tokens, machine IDs, private URLs). This repo ignores `*.env`.
- `fish/config.fish` sources `~/.config/gemini.env` and `~/.fish_profile`. These are machine-local and must stay gitignored.

## Commit & Pull Request Guidelines
- Commits follow Conventional Commits style seen in history: `feat: …`, `fix: …`, `chore: …`, `refactor(config): …`, `test: …`.
- PRs should include: what changed, which apps/paths are affected, and any manual verification steps. Include screenshots/gifs for UI changes (`waybar/`, `rofi/`, themes).

# Repository Guidelines

## Project Structure & Module Organization

- `init.lua`: Entry point. Keep it small and only do early bootstrapping.
- `lua/config/`: Core editor setup.
  - `early.lua`: Environment + filetype/treesitter setup that must run before plugins.
  - `options.lua`, `autocmds.lua`: Editor behavior.
  - `lazy.lua`: `lazy.nvim` bootstrap + setup.
- `lua/plugins/`: Plugin specs and overrides (one concern per file, e.g. `lsp.lua`, `formatting.lua`, `snacks.lua`).
- `lazyvim.json`: LazyVim “extras” list (treat this as the source of truth for enabled extras).
- `stylua.toml`: Lua formatting rules.

## Build, Test, and Development Commands

- Start Neovim: `nvim`
- Plugin management: `:Lazy` (sync/update/clean)
- Formatter health and selection: `:ConformInfo`
- Sanity checks (headless):
  - `nvim --headless "+checkhealth" +qa`
  - `nvim --headless "+LazyHealth" +qa`
- Treesitter maintenance: `:TSUpdate` (after adding parsers in `lua/plugins/treesitter.lua`)
- Format Lua files: `stylua .`

## Coding Style & Naming Conventions

- Indentation: 2 spaces (see `stylua.toml`).
- Prefer small, focused modules under `lua/plugins/` (avoid “god files”).
- Use `opts = function(_, opts) ... end` for plugin overrides so defaults from LazyVim merge cleanly.
- Keep runtime side effects out of module top-levels; prefer `config = function()` or `init = function()`.
- Prefer tool configs over CLI flags when possible (e.g. Prettier via `~/.config/prettier/.prettierrc.json`).

## Testing Guidelines

This repo has no unit tests. Validate changes by:

- Running `:checkhealth`, `:LazyHealth`, and opening a few representative filetypes (Lua, TS/TSX, YAML, Markdown).
- Watching startup warnings: `:messages` and logs in `~/.local/state/nvim/` (e.g. `lsp.log`, `conform.log`).

## Commit & Pull Request Guidelines

- Commit style follows Conventional Commits (see history): `feat: …`, `fix: …`, `chore: …`, `refactor(config): …`.
- PRs should include:
  - A short “what/why” description.
  - Screenshots/gifs for UI changes (statusline, dashboard, colorscheme).
  - Notes on new external dependencies (e.g. `lazygit`, `tree-sitter`, formatters).

## Formatting & Linting Notes

- C/C++ formatting is enforced via `clang-format --style=Google` (see `lua/plugins/formatting.lua`).
- Markdown formatting uses Prettier/`prettierd` with shared defaults from `~/.config/prettier/.prettierrc.json`.
- Markdown linting disables MD013 (line-length) to avoid noisy warnings.

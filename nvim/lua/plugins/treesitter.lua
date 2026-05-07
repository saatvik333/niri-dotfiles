return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "c",
        "cmake",
        "cpp",
        "css",
        "diff",
        "dockerfile",
        "git_config",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "html",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "latex",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "rasi",
        "rust",
        "ron",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "typst",
        "vim",
        "vimdoc",
        "vue",
        "svelte",
        "yaml",
      })
      opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
      opts.highlight = opts.highlight or {}
      opts.highlight.enable = true
    end,
  },
}

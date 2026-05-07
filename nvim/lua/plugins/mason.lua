return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "lua-language-server",
        "pyright",
        "ruff",
        "vtsls",
        "eslint-lsp",
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",
        "json-lsp",
        "yaml-language-server",
        "taplo",
        "marksman",
        "rust-analyzer",
        "gopls",
        "clangd",
        "neocmakelsp",
        "dockerfile-language-server",
        "docker-compose-language-service",
        "tree-sitter-cli",
        "stylua",
        "prettierd",
        "shfmt",
        "rustfmt",
        "gofumpt",
        "goimports",
        "shellcheck",
        "yamllint",
        "markdownlint",
        "hadolint",
      })

      opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
    end,
  },
}

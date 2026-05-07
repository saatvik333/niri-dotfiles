return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_organize_imports", "ruff_format" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        vue = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
        scss = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        ["markdown.mdx"] = { "prettierd" },
        sh = { "shfmt" },
        rust = { "rustfmt" },
        go = { "gofumpt", "goimports" },
        toml = { "taplo" },
        cpp = { "clang-format" },
        c = { "clang-format" },
        ["*"] = { "trim_whitespace" },
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-ci", "-sr" },
        },
        rustfmt = {
          prepend_args = { "--edition", "2021" },
        },
        stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2", "--column-width", "120" },
        },
        ["clang-format"] = {
          prepend_args = { "--style=Google" },
        },
        ruff_organize_imports = {
          condition = function()
            return vim.fn.executable("ruff") == 1
          end,
        },
        ruff_format = {
          condition = function()
            return vim.fn.executable("ruff") == 1
          end,
        },
      },
    },
  },
}

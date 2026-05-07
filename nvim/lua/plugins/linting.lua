return {
  {
    "mfussenegger/nvim-lint",
    event = "LazyFile",
    opts = {
      events = { "BufWritePost" },
      linters_by_ft = {
        python = { "ruff" },
        sh = { "shellcheck" },
        yaml = { "yamllint" },
        markdown = { "markdownlint" },
        dockerfile = { "hadolint" },
        ["*"] = { "typos" },
      },
      linters = {
        typos = {
          condition = function(ctx)
            return vim.fn.executable("typos") == 1
              and vim.fs.find({ "typos.toml", ".typos.toml" }, { path = ctx.filename, upward = true })[1]
          end,
        },
        markdownlint = {
          args = { "--stdin", "--disable", "MD013" },
          condition = function()
            return vim.fn.executable("markdownlint") == 1
          end,
        },
        yamllint = {
          condition = function()
            return vim.fn.executable("yamllint") == 1
          end,
        },
        hadolint = {
          condition = function()
            return vim.fn.executable("hadolint") == 1
          end,
        },
        shellcheck = {
          condition = function()
            return vim.fn.executable("shellcheck") == 1
          end,
        },
        ruff = {
          condition = function()
            return vim.fn.executable("ruff") == 1
          end,
        },
      },
    },
  },
}

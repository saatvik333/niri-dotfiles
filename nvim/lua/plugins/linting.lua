local has = setmetatable({}, {
  __index = function(t, name)
    local ok = vim.fn.executable(name) == 1
    rawset(t, name, ok)
    return ok
  end,
})

local function typos_config_present(filename)
  return vim.fs.find({ "typos.toml", ".typos.toml" }, { path = filename, upward = true })[1] ~= nil
end

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
            if not has["typos"] then
              return false
            end
            local bufnr = ctx.bufnr or vim.api.nvim_get_current_buf()
            local cached = vim.b[bufnr].typos_enabled
            if cached ~= nil then
              return cached
            end
            local enabled = typos_config_present(ctx.filename)
            vim.b[bufnr].typos_enabled = enabled
            return enabled
          end,
        },
        markdownlint = {
          args = { "--stdin", "--disable", "MD013" },
          condition = function()
            return has["markdownlint"]
          end,
        },
        yamllint = {
          condition = function()
            return has["yamllint"]
          end,
        },
        hadolint = {
          condition = function()
            return has["hadolint"]
          end,
        },
        shellcheck = {
          condition = function()
            return has["shellcheck"]
          end,
        },
        ruff = {
          condition = function()
            return has["ruff"]
          end,
        },
      },
    },
  },
}

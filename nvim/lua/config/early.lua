do
  local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
  local path = vim.env.PATH or ""
  if not path:find(mason_bin, 1, true) then
    vim.env.PATH = path == "" and mason_bin or (path .. ":" .. mason_bin)
  end
end

do
  local default_config = vim.fn.expand("~/.config/prettier/.prettierrc.json")
  if vim.fn.filereadable(default_config) == 1 then
    vim.env.PRETTIERD_DEFAULT_CONFIG = default_config
  end
end

-- Disable unused language providers for faster startup.
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.filetype.add({
  extension = {
    mdx = "markdown.mdx",
  },
  filename = {
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["compose.yml"] = "yaml.docker-compose",
    ["compose.yaml"] = "yaml.docker-compose",
  },
})

pcall(function()
  vim.treesitter.language.register("yaml", "yaml.docker-compose")
  vim.treesitter.language.register("markdown", "markdown.mdx")
end)

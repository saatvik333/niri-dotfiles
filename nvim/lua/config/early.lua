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

-- Workaround for a vim treesitter query mismatch (invalid node type "tab").
pcall(function()
  local ok = pcall(vim.treesitter.query.get, "vim", "highlights")
  if ok then
    return
  end

  local files = vim.api.nvim_get_runtime_file("queries/vim/highlights.scm", true)
  if #files == 0 then
    return
  end

  local query = table.concat(vim.fn.readfile(files[1]), "\n")
  query = query:gsub('\n%s*"tab"%s*\n', "\n")
  vim.treesitter.query.set("vim", "highlights", query)
end)

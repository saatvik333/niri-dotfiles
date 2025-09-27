-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.autochdir = true
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#1E1E2E", fg = "#CDD6F4" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#1E1E2E", fg = "#BAC2DE" })
vim.api.nvim_set_hl(0, "StatusLineTerm", { bg = "#1E1E2E", fg = "#CDD6F4" })
vim.cmd.colorscheme("neopywal")
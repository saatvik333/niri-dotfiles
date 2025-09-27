-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.autochdir = true
vim.api.nvim_set_hl(0, "StatusLine", { bg = "{{background}}", fg = "{{foreground}}" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "{{background}}", fg = "{{color7}}" })
vim.api.nvim_set_hl(0, "StatusLineTerm", { bg = "{{background}}", fg = "{{foreground}}" })
vim.cmd.colorscheme("neopywal")
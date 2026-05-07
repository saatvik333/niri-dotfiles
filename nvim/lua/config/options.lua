do
  local state_dir = vim.fn.stdpath("state")
  local swap_dir = state_dir .. "/swap"
  local undo_dir = state_dir .. "/undo"

  vim.fn.mkdir(swap_dir, "p")
  vim.fn.mkdir(undo_dir, "p")

  vim.opt.swapfile = true
  vim.opt.directory = { swap_dir .. "//", "." }

  vim.opt.undofile = true
  vim.opt.undodir = { undo_dir .. "//", "." }
end

vim.opt.backup = false
vim.o.autoread = true

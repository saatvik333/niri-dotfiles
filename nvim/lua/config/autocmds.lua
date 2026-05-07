vim.api.nvim_create_autocmd("SwapExists", {
  callback = function()
    local swapfile = vim.v.swapname
    local original = vim.fn.getftime(vim.fn.expand("<afile>:p"))
    local swap_modified = vim.fn.getftime(swapfile)

    if original >= swap_modified then
      -- file is newer than swap — swap is stale, just delete it and edit normally
      os.remove(swapfile)
      vim.v.swapchoice = "e"
      vim.notify("Deleted stale swap file", vim.log.levels.INFO)
    else
      -- swap is newer — recover to avoid data loss
      vim.v.swapchoice = "r"
      vim.defer_fn(function()
        if vim.fn.filereadable(swapfile) == 1 then
          os.remove(swapfile)
          vim.notify("Recovered and deleted swap file", vim.log.levels.INFO)
        end
      end, 100)
    end
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"

    local opts = { buffer = 0, silent = true }
    vim.keymap.set("t", "<C-Esc>", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
    vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
    vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
    vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
  end,
})

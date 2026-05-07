return {
  {
    "LazyVim/LazyVim",
    opts = {
      news = {
        lazyvim = false,
      },
      colorscheme = function()
        require("lazy").load({ plugins = { "neopywal" } })
        vim.cmd.colorscheme("neopywal-dark")
      end,
    },
  },
}

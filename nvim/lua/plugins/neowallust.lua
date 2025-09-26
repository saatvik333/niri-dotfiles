return {
    "RedsXDD/neopywal.nvim",
    name = "neopywal",
    lazy = false,
    priority = 1000,
    version = "*",
    config = function()
      require("neopywal").setup({
        use_wallust = true,
        transparent_background = true,
      })
    end,
}

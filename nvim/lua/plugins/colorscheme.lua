return {
  {
    "RedsXDD/neopywal.nvim",
    name = "neopywal",
    priority = 1000,
    config = function()
      require("neopywal").setup({
        transparent_background = true,
        use_palette = {
          dark = "wallust",
          light = "wallust",
        },
        custom_colors = {
          light = function(C)
            local U = require("neopywal.utils.color")
            -- Since wallust already provides a light palette, we need to un-invert
            -- what neopywal-light did by default. We modify C in-place so that
            -- all extra palette colors (like strings and info) use the correct foreground.
            local bg = C.foreground
            local fg = C.background
            C.background = bg
            C.foreground = fg
            return {
              background = bg,
              foreground = fg,
              dim_bg = U.darken(bg, 5),
              cursorline = U.blend(bg, fg, 0.9),
            }
          end,
        },
      })
    end,
  },
}

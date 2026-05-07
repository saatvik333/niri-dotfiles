return {
  "nvimdev/dashboard-nvim",
  lazy = false,
  opts = function(_, opts)
    local logo = [[

⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⡀⢄⢮⡳⣶⢭⣖⣢⡤⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢀⢤⣢⣵⣾IuseNVIM⣿⣶⣯⣵⣒⡠⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢸⣎⣿⣿⣿⣿^⡿⠛⠛⠻⣿⣿⣿⣿⣿⣿⡇⣿⣟⣵⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢸⡇⠼⣿⣿⣿⡟⠀⢠⣤⢸⡊⢻⣿⡿⣿⣿⡇⣿⣿⣷⣝⣕⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢸⡇⢑⢻⣿⣿⣧⡀⣅⡡⣠⠆⠹⣿⣿⣿⣿⣷⣿⣿⣿⣿⣷⢟⢯⠢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢸⡇⣸⢉⢿⣯⣿⣿⣶⣧⣤⣰⣾⣿⡟⠽⣋⣈⢿⣿⣿⣿⣿⢸⣷⣝⠮⡢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢸⣷⣿⠠⣞⢿⣿⣿⣿⣿⢟⡫⡗⡢⡑⢭⣗⡺⢷⣙⠿⣿⣿⣼⣿⢿⣷⣍⣎⡢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢸⣿⣿⣼⡏⠗⢝⢿⣿⡈⢥⣿⠞⡜⡼⣾⣛⢿⣛⣻⣷⣰⠹⣻⣿⣿⣿⣿⣿⣮⡪⡢⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣸⣿⣿⣾⡇⠄⠁⠋⣊⢟⠬⡻⣯⡵⣣⡻⣟⡦⢾⣿⣋⣇⢉⣿⣿⣿⣿⣿⣿⣿⣿⣿⡪⡢⡀⠀⠀⠀⠀⠀⠀⠀
⠠⠰⣹⢔⠹⣿⣿⣫⠁⠀⢰⡌⢿⡎⢜⠝⡿⣟⡫⢗⡫⠏⠙⢫⣵⠘⣄⡘⠿⣿⣿⣿⣿⣿⣿⣿⣾⣮⡢⡀⠀⠀⠀⠀⠀
⠀⠀⠀⠄⡚⠘⢿⣯⡅⠀⢸⠇⠄⠀⠀⠉⠲⠔⡱⡻⢿⣽⣁⠢⢼⣶⣿⣿⣷⣬⡉⡹⠿⣿⣿⣿⣿⣿⣯⡪⡢⡀⠀⠀⠀
⠀⠀⠠⠀⢀⠄⠎⢿⣷⠀⢸⠇⡄⡆⡌⠁⡂⠀⡘⢠⠱⠨⢛⢿⣶⣬⡉⡹⠻⣿⣷⣢⣄⠙⢿⣿⣿⣿⣿⡿⠞⢞⡆⠀⠀
⠀⠀⠀⠀⠈⠈⠒⠊⡻⡇⡄⡒⠤⡀⠁⠃⠁⢠⢀⠁⠀⠀⠂⢉⢊⠝⠿⣶⡤⡘⢿⣿⣷⣝⢦⣙⠿⡛⣉⣼⣾⣿⡇⠀⠀
⠀⠀⠀⠀⠀⠘⠠⢬⠐⠱⠺⢵⡣⢆⡅⢆⡎⠘⠈⠘⢰⠰⠀⠃⠎⡔⠸⢐⠹⢻⢵⡩⣛⢟⢋⣡⣵⣿⡟⢹⢿⣿⡇⠀⠀
⠀⠀⠀⠀⠀⠀⠂⠄⡈⢀⠀⠑⢉⢓⠾⡥⢨⠐⡠⣀⠂⠆⡄⡄⡀⠐⢀⠀⡌⡖⢌⠪⣤⢾⣿⣿⣿⣏⣍⢰⣿⢿⡇⢤⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠋⠐⠁⠀⠈⠐⠱⠁⢊⢅⡃⠉⢒⠤⡁⠃⠦⢌⠘⠀⠁⠀⠂⣿⣿⣿⣿⣿⣿⣧⣸⣾⣿⡇⢠⠰
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⠄⠄⡀⠂⠅⠌⠕⣰⢈⠒⠵⢢⢎⣐⠀⡃⠄⠀⣿⢷⣿⣿⣿⣟⣯⣷⠿⢻⢱⠂⠈
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠈⠀⢉⢒⠄⡂⡖⡩⢒⠄⠀⣿⡿⣟⣽⣾⡟⡏⠆⠀⠑⠈⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠄⠂⠈⠈⢑⠣⢇⡎⠄⣿⣿⡿⡉⠃⠃⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠀⠁⠁⠀⠎⠛⠉⡀⠉⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀
]]

    logo = string.rep("\n", 4) .. logo .. "\n"

    opts.theme = "doom"
    opts.hide = vim.tbl_extend("force", opts.hide or {}, { statusline = false })
    opts.config = opts.config or {}
    opts.config.header = vim.split(logo, "\n")
    opts.config.center = {
      { action = "lua LazyVim.pick()()", desc = " Find File", icon = "󰍉 ", key = "f" },
      { action = 'lua LazyVim.pick("live_grep")()', desc = " Find Text", icon = "󱩾 ", key = "g" },
      { action = 'lua require("persistence").load()', desc = " Restore Session", icon = "󰦛 ", key = "s" },
      { action = "LazyExtras", desc = " Lazy Extras", icon = "󰏗 ", key = "x" },
      {
        action = function()
          vim.api.nvim_input("<cmd>qa<cr>")
        end,
        desc = " Quit",
        icon = "󰈆 ",
        key = "q",
      },
    }
    opts.config.footer = function()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
    end

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 40 - #button.desc)
      button.key_format = "  %s"
    end

    return opts
  end,
}

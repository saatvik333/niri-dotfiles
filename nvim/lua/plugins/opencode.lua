return {
  {
    "nickjvandyke/opencode.nvim",
    version = "*",
    dependencies = {
      {
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {},
          picker = {
            actions = {
              opencode_send = function(...)
                return require("opencode").snacks_picker_send(...)
              end,
            },
            win = {
              input = {
                keys = {
                  ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
          terminal = {},
        },
      },
    },
    keys = {
      {
        "<leader>oa",
        function()
          require("opencode").ask("@this: ", { submit = true })
        end,
        mode = { "n", "x" },
        desc = "Ask opencode…",
      },
      {
        "<leader>oo",
        function()
          require("opencode").select()
        end,
        mode = { "n", "x" },
        desc = "Execute opencode action…",
      },
      {
        "<leader>ot",
        function()
          require("opencode").toggle()
        end,
        mode = { "n", "t" },
        desc = "Toggle opencode",
      },
      {
        "go",
        function()
          return require("opencode").operator("@this ")
        end,
        mode = { "n", "x" },
        expr = true,
        desc = "Add range to opencode",
      },
      {
        "goo",
        function()
          return require("opencode").operator("@this ") .. "_"
        end,
        mode = "n",
        expr = true,
        desc = "Add line to opencode",
      },
      {
        "<leader>ou",
        function()
          require("opencode").command("session.half.page.up")
        end,
        mode = "n",
        desc = "Scroll opencode up",
      },
      {
        "<leader>od",
        function()
          require("opencode").command("session.half.page.down")
        end,
        mode = "n",
        desc = "Scroll opencode down",
      },
    },
  },
}

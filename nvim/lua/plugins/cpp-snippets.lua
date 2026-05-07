return {
  {
    name = "cpp-snippets",
    dir = vim.fn.stdpath("config"),
    ft = { "cpp" },
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local ls = require("luasnip")
      local templates = require("util.cpp_templates")

      local function build_snippet(template)
        local nodes = {}
        for _, seg in ipairs(template.segments) do
          if seg.kind == "text" then
            table.insert(nodes, ls.text_node(seg.lines))
          elseif seg.kind == "insert" then
            table.insert(nodes, ls.insert_node(seg.index))
          end
        end
        return ls.snippet(template.trigger, nodes)
      end

      local snippets = {}
      for _, template in ipairs(templates.list) do
        table.insert(snippets, build_snippet(template))
      end
      ls.add_snippets("cpp", snippets)
    end,
  },
}

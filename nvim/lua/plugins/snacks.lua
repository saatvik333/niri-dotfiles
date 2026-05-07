return {
  {
    "folke/snacks.nvim",
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          local ok, tree = pcall(require, "snacks.explorer.tree")
          if not ok or tree.__natural_sort_patched then
            return
          end
          tree.__natural_sort_patched = true

          local function chunk(str, idx)
            local sub = str:sub(idx)
            local digits = sub:match("^(%d+)")
            if digits then
              return true, digits, idx + #digits
            end
            local nondigits = sub:match("^(%D+)")
            return false, nondigits or "", idx + #(nondigits or "")
          end

          local function natural_lt(a, b)
            if a == b then
              return false
            end

            local ai, bi = 1, 1
            local al, bl = #a, #b
            while ai <= al and bi <= bl do
              local anum, ach, anext = chunk(a, ai)
              local bnum, bch, bnext = chunk(b, bi)

              if anum and bnum then
                local av = tonumber(ach) or 0
                local bv = tonumber(bch) or 0
                if av ~= bv then
                  return av < bv
                end
                if #ach ~= #bch then
                  return #ach < #bch
                end
              else
                local alow = ach:lower()
                local blow = bch:lower()
                if alow ~= blow then
                  return alow < blow
                end
              end

              ai, bi = anext, bnext
            end

            return al < bl
          end

          tree.walk = function(self, node, fn, opts)
            local abort = fn(node)
            if abort ~= nil then
              return abort
            end

            local children = vim.tbl_values(node.children)
            table.sort(children, function(a, b)
              if a.dir ~= b.dir then
                return a.dir
              end
              return natural_lt(a.name, b.name)
            end)

            for c, child in ipairs(children) do
              child.last = c == #children
              abort = false
              if child.dir and (child.open or (opts and opts.all)) then
                abort = self:walk(child, fn, opts)
              else
                abort = fn(child)
              end
              if abort then
                return true
              end
            end
            return false
          end
        end,
      })
    end,
  },
}


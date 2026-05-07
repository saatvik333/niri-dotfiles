return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      if opts.servers.vtsls then
        opts.servers.vtsls.filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
      end
      if opts.servers.eslint then
        opts.servers.eslint.filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "svelte",
          "astro",
          "htmlangular",
        }
      end
      if opts.servers.angularls then
        opts.servers.angularls.filetypes = { "typescript", "html", "typescriptreact", "htmlangular" }
      end

      if opts.servers.clangd then
        local prev_on_attach = opts.servers.clangd.on_attach
        opts.servers.clangd.on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          if prev_on_attach then
            prev_on_attach(client, bufnr)
          end
        end

        local cmd = opts.servers.clangd.cmd
        if type(cmd) == "table" then
          local found = false
          for i, arg in ipairs(cmd) do
            if type(arg) == "string" and arg:match("^%-%-fallback%-style=") then
              cmd[i] = "--fallback-style=Google"
              found = true
              break
            end
          end
          if not found then
            table.insert(cmd, "--fallback-style=Google")
          end
        end
      end
    end,
  },
}

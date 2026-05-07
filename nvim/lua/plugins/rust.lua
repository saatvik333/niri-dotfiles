return {
  {
    "mrcjkb/rustaceanvim",
    config = function(_, opts)
      if LazyVim.has("mason.nvim") and LazyVim.has("nvim-dap") then
        local codelldb = vim.fn.exepath("codelldb")
        local sysname = ((vim.uv or vim.loop).os_uname() or {}).sysname
        local codelldb_lib_ext = sysname == "Linux" and ".so" or ".dylib"
        local library_path = vim.fn.expand("$MASON/opt/lldb/lib/liblldb" .. codelldb_lib_ext)
        opts.dap = {
          adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path),
        }
      end

      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
      if vim.fn.executable("rust-analyzer") == 0 then
        LazyVim.error(
          "**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
          { title = "rustaceanvim" }
        )
      end
    end,
  },
}

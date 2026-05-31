return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      latex = { enabled = false },
    },
  },
  {
    "selimacerbas/markdown-preview.nvim",
    dependencies = { "selimacerbas/live-server.nvim" },
    cmd = { "MarkdownPreview", "MarkdownPreviewRefresh", "MarkdownPreviewStop" },
    keys = {
      { "<leader>mps", "<cmd>MarkdownPreview<cr>", desc = "Markdown: Start preview" },
      { "<leader>mpS", "<cmd>MarkdownPreviewStop<cr>", desc = "Markdown: Stop preview" },
      { "<leader>mpr", "<cmd>MarkdownPreviewRefresh<cr>", desc = "Markdown: Refresh preview" },
    },
    config = function()
      require("markdown_preview").setup({
        instance_mode = "takeover",
        port = 0,
        open_browser = true,
        debounce_ms = 300,
      })
    end,
  },
}

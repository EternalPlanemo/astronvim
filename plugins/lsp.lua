return {
  "williamboman/mason-lspconfig.nvim",
  { "lvimuser/lsp-inlayhints.nvim", config = true },
  {
    "Maan2003/lsp_lines.nvim",
    event = "User AstroFile",
    config = function() require("lsp_lines").setup() end,
  },

  {
    "p00f/clangd_extensions.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    opts = function()
      return {
        server = require("astronvim.utils.lsp").config "clangd",
        extensions = { autoSetHints = true },
        ensure_installed = { "clangd" }
      }
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    ft = { "rust" },
    opts = function() return { server = require("astronvim.utils.lsp").config "rust_analyzer" } end,
    config = true,
  },
}

-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = {
        "rust_analyzer",
        "emmet_ls",
        "intelephense",
        "lua_ls",
        "pylsp",
        "rust_analyzer",
        "tailwindcss",
        "tsserver",
        "jsonls",
        "sqlls",
        "clangd",
      }
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = {
        "pint",
        "prettier",
        "rustfmt",
        "markdownlint",
      }
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      -- ensure_installed = { "python" },
    },
  },
}

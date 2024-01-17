return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      local luasnip_configs = require "plugins.configs.luasnip"
        luasnip_configs(plugin, opts)  -- include the default astronvim config that calls the setup call

        opts = opts or {}
        opts.region_check_events = "CursorHold,InsertLeave"
        opts.delete_check_events = "TextChanged,InsertEnter"

        require("luasnip.loaders.from_vscode").lazy_load { paths = { "./lua/user/snippets" } } -- load snippets paths
    end,
  },
  "sainnhe/edge",
}

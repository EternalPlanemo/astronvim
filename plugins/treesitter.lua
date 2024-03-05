return {
  "nvim-treesitter/nvim-treesitter",
    -- ---@class ParserInfo[]
    -- local parser_config = require("nvim-treesitter.parsers").get_parser_configs();
    --
    -- parser_config.blade = {
    --   install_info = {
    --     url = "~/.config/nvim/lua/user/plugins/tree-sitter-blade",
    --     files = { "src/parser.c" },
    --     branch = "master",
    --     generate_requires_npm = true,
    --     requires_generate_from_grammar = true,
    --   },
    --   filetype = "blade"
    -- }

  opts = {
    ensure_installed = {
      "c",
      "cpp",
      "lua",
      "vim",
      "php",
      "rust",
      "javascript",
      "typescript",
      "twig",
      "zig",
    },
  }
}

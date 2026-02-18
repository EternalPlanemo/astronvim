-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, config)
    local null_ls = require "null-ls"
    local helpers = require "null-ls.helpers"

    config.sources = {
      -- 2. Your existing PHPStan diagnostics
      null_ls.builtins.diagnostics.phpstan.with {
        args = {
          "analyse",
          "--level=max",
          "--error-format=json",
          "--no-progress",
          "--memory-limit=4G",
          "$FILENAME",
        },
      },
    }

    return config
  end,
}

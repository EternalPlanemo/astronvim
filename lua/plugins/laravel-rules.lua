---@type LazySpec
return {
  dir = vim.fn.stdpath "config" .. "/local-plugins/laravel-rules",
  name = "laravel-rules", 
  ft = { "php" },
  cmd = { "LaravelConvertRules" },
  config = function() require("laravel-rules").setup() end,
}

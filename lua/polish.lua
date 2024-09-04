-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    [".neon"] = "yaml",
  },
  filename = {
    ["phpstan.neon"] = "yaml",
  },
  pattern = {
    [".env.*"] = "sh",
    [".*%.blade%.php"] = "blade",
  },
}

-- edit.blade.php

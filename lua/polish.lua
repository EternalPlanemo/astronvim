if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

if vim.g.neovide and jit.os == "OSX" then vim.g.neovide_scale_factor = 1.25 end
if vim.g.neovide and jit.os == "Linux" then vim.g.neovide_opacity = 0.9 end

if vim.g.neovide and jit.os == "OSX" then
  vim.keymap.set(
    { "n", "v", "s", "x", "o", "i", "l", "c", "t" },
    "<D-v>",
    function() vim.api.nvim_paste(vim.fn.getreg "+", true, -1) end,
    { noremap = true, silent = true }
  )
end

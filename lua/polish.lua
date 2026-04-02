-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

vim.o.guifont = "FiraCode Nerd Font Mono:h16"

-- Bulgarian phonetic layout -> US QWERTY command aliases.
-- This lets normal/visual/operator commands work while Cyrillic input is active.
local bg_to_en = {
  ["я"] = "q",
  ["в"] = "w",
  ["е"] = "e",
  ["р"] = "r",
  ["т"] = "t",
  ["ъ"] = "y",
  ["у"] = "u",
  ["и"] = "i",
  ["о"] = "o",
  ["п"] = "p",
  ["ш"] = "[",
  ["щ"] = "]",
  ["а"] = "a",
  ["с"] = "s",
  ["д"] = "d",
  ["ф"] = "f",
  ["г"] = "g",
  ["х"] = "h",
  ["й"] = "j",
  ["к"] = "k",
  ["л"] = "l",
  ["ў"] = "'",
  ["ч"] = "z",
  ["ь"] = "x",
  ["ц"] = "c",
  ["ж"] = "v",
  ["б"] = "b",
  ["н"] = "n",
  ["м"] = "m",
}

local bg_to_en_upper = {
  ["Я"] = "Q",
  ["В"] = "W",
  ["Е"] = "E",
  ["Р"] = "R",
  ["Т"] = "T",
  ["Ъ"] = "Y",
  ["У"] = "U",
  ["И"] = "I",
  ["О"] = "O",
  ["П"] = "P",
  ["Ш"] = "{",
  ["Щ"] = "}",
  ["А"] = "A",
  ["С"] = "S",
  ["Д"] = "D",
  ["Ф"] = "F",
  ["Г"] = "G",
  ["Х"] = "H",
  ["Й"] = "J",
  ["К"] = "K",
  ["Л"] = "L",
  ["Ў"] = '"',
  ["Ч"] = "Z",
  ["Ь"] = "X",
  ["Ц"] = "C",
  ["Ж"] = "V",
  ["Б"] = "B",
  ["Н"] = "N",
  ["М"] = "M",
}

local map_opts = { noremap = true, silent = true }
for bg, en in pairs(bg_to_en) do
  vim.keymap.set({ "n", "x", "o" }, bg, en, map_opts)
  vim.keymap.set({ "n", "x" }, "<C-" .. bg .. ">", "<C-" .. en .. ">", map_opts)
end
for bg, en in pairs(bg_to_en_upper) do
  vim.keymap.set({ "n", "x", "o" }, bg, en, map_opts)
  vim.keymap.set({ "n", "x" }, "<C-" .. bg .. ">", "<C-" .. en .. ">", map_opts)
end

if vim.g.neovide and jit.os == "OSX" then
  vim.keymap.set(
    { "n", "v", "s", "x", "o", "i", "l", "c", "t" },
    "<D-v>",
    function() vim.api.nvim_paste(vim.fn.getreg "+", true, -1) end,
    { noremap = true, silent = true }
  )
end

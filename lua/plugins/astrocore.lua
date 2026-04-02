-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

-- Helper function for transparency formatting
local alpha = function() return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8))) end

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = false, -- enable notifications at start
    },
    -- AstroNvim v6 manages Treesitter features here instead of nvim-treesitter modules
    treesitter = {
      ensure_installed = {
        "lua",
        "vim",
        "php",
        "javascript",
        "typescript",
        "zig",
        "go",
        "html",
        "nu",
      },
      highlight = true,
    },
    -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        [".neon"] = "yaml",
      },
      filename = {
        ["phpstan.neon"] = "yaml",
        [".rules"] = "firestore_rules",
        ["firestore.rules"] = "firestore_rules",
      },
      pattern = {
        [".env.*"] = "sh",
        [".*%.blade%.php"] = "blade",
      },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to auto
        wrap = true, -- sets vim.opt.wrap
      },
      g = {
        neovide_opacity = 0.8,
        neovide_window_blurred = true,
        transparency = 0.4,
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- Bulgarian Cyrillic aliases for core motions
        ["х"] = { "h", desc = "Left (Cyrillic)" },
        ["й"] = { "j", desc = "Down (Cyrillic)" },
        ["к"] = { "k", desc = "Up (Cyrillic)" },
        ["л"] = { "l", desc = "Right (Cyrillic)" },
        ["Х"] = { "H", desc = "Top of screen (Cyrillic)" },
        ["М"] = { "M", desc = "Middle of screen (Cyrillic)" },
        ["Л"] = { "L", desc = "Bottom of screen (Cyrillic)" },
        ["в"] = { "w", desc = "Next word (Cyrillic)" },
        ["б"] = { "b", desc = "Previous word (Cyrillic)" },
        ["е"] = { "e", desc = "End of word (Cyrillic)" },
        ["В"] = { "W", desc = "Next WORD (Cyrillic)" },
        ["Б"] = { "B", desc = "Previous WORD (Cyrillic)" },
        ["Е"] = { "E", desc = "End of WORD (Cyrillic)" },
        ["ге"] = { "ge", desc = "End of previous word (Cyrillic)" },
        ["гЕ"] = { "gE", desc = "End of previous WORD (Cyrillic)" },
        ["гг"] = { "gg", desc = "Top of file (Cyrillic)" },
        ["Г"] = { "G", desc = "Bottom of file (Cyrillic)" },
        ["ф"] = { "f", desc = "Find char forward (Cyrillic)" },
        ["Ф"] = { "F", desc = "Find char backward (Cyrillic)" },
        ["т"] = { "t", desc = "Till char forward (Cyrillic)" },
        ["Т"] = { "T", desc = "Till char backward (Cyrillic)" },
        ["н"] = { "n", desc = "Next search match (Cyrillic)" },
        ["Н"] = { "N", desc = "Previous search match (Cyrillic)" },
        ["г*"] = { "g*", desc = "Next partial match (Cyrillic)" },
        ["г#"] = { "g#", desc = "Previous partial match (Cyrillic)" },
        ["*"] = { "*", desc = "Search word forward" },
        ["#"] = { "#", desc = "Search word backward" },
        ["0"] = { "0", desc = "Line start" },
        ["^"] = { "^", desc = "First non-blank" },
        ["$"] = { "$", desc = "Line end" },
        ["+"] = { "+", desc = "Next line first non-blank" },
        ["-"] = { "-", desc = "Previous line first non-blank" },
        ["_"] = { "_", desc = "Line first non-blank (count aware)" },
        ["|"] = { "|", desc = "Go to column" },
        ["%"] = { "%", desc = "Matching pair" },
        ["("] = { "(", desc = "Previous sentence" },
        [")"] = { ")", desc = "Next sentence" },
        ["{"] = { "{", desc = "Previous paragraph" },
        ["}"] = { "}", desc = "Next paragraph" },
        [";"] = { ";", desc = "Repeat find" },
        [","] = { ",", desc = "Repeat find reverse" },
        ["гй"] = { "gj", desc = "Down display line (Cyrillic)" },
        ["гк"] = { "gk", desc = "Up display line (Cyrillic)" },
        ["г0"] = { "g0", desc = "Display line start (Cyrillic)" },
        ["г$"] = { "g$", desc = "Display line end (Cyrillic)" },
        ["г^"] = { "g^", desc = "Display line first non-blank (Cyrillic)" },
        ["г_"] = { "g_", desc = "Display line last non-blank (Cyrillic)" },
        ["зз"] = { "zz", desc = "Center cursor line (Cyrillic)" },
        ["зт"] = { "zt", desc = "Cursor line to top (Cyrillic)" },
        ["зб"] = { "zb", desc = "Cursor line to bottom (Cyrillic)" },

        -- second key is the lefthand side of the map

        -- navigate buffer tabs with `H` and `L`
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        -- quick save
        ["<Leader>fg"] = {
          function() require("snacks.picker").git_status() end,
          desc = "Find files with Git changes",
        },
        ["<Leader>D"] = {
          "<cmd>DBUIToggle<cr>",
          desc = "Toggle DB",
        },
        ["<Leader>U"] = {
          vim.cmd.UndotreeToggle,
          desc = "Toggle Undo Tree",
        },
      },
      v = {
        ["х"] = { "h", desc = "Left (Cyrillic)" },
        ["й"] = { "j", desc = "Down (Cyrillic)" },
        ["к"] = { "k", desc = "Up (Cyrillic)" },
        ["л"] = { "l", desc = "Right (Cyrillic)" },
        ["Х"] = { "H", desc = "Top of screen (Cyrillic)" },
        ["М"] = { "M", desc = "Middle of screen (Cyrillic)" },
        ["Л"] = { "L", desc = "Bottom of screen (Cyrillic)" },
        ["в"] = { "w", desc = "Next word (Cyrillic)" },
        ["б"] = { "b", desc = "Previous word (Cyrillic)" },
        ["е"] = { "e", desc = "End of word (Cyrillic)" },
        ["В"] = { "W", desc = "Next WORD (Cyrillic)" },
        ["Б"] = { "B", desc = "Previous WORD (Cyrillic)" },
        ["Е"] = { "E", desc = "End of WORD (Cyrillic)" },
        ["ге"] = { "ge", desc = "End of previous word (Cyrillic)" },
        ["гЕ"] = { "gE", desc = "End of previous WORD (Cyrillic)" },
        ["гг"] = { "gg", desc = "Top of file (Cyrillic)" },
        ["Г"] = { "G", desc = "Bottom of file (Cyrillic)" },
        ["ф"] = { "f", desc = "Find char forward (Cyrillic)" },
        ["Ф"] = { "F", desc = "Find char backward (Cyrillic)" },
        ["т"] = { "t", desc = "Till char forward (Cyrillic)" },
        ["Т"] = { "T", desc = "Till char backward (Cyrillic)" },
        ["н"] = { "n", desc = "Next search match (Cyrillic)" },
        ["Н"] = { "N", desc = "Previous search match (Cyrillic)" },
        ["г*"] = { "g*", desc = "Next partial match (Cyrillic)" },
        ["г#"] = { "g#", desc = "Previous partial match (Cyrillic)" },
        ["*"] = { "*", desc = "Search word forward" },
        ["#"] = { "#", desc = "Search word backward" },
        ["0"] = { "0", desc = "Line start" },
        ["^"] = { "^", desc = "First non-blank" },
        ["$"] = { "$", desc = "Line end" },
        ["+"] = { "+", desc = "Next line first non-blank" },
        ["-"] = { "-", desc = "Previous line first non-blank" },
        ["_"] = { "_", desc = "Line first non-blank (count aware)" },
        ["|"] = { "|", desc = "Go to column" },
        ["%"] = { "%", desc = "Matching pair" },
        ["("] = { "(", desc = "Previous sentence" },
        [")"] = { ")", desc = "Next sentence" },
        ["{"] = { "{", desc = "Previous paragraph" },
        ["}"] = { "}", desc = "Next paragraph" },
        [";"] = { ";", desc = "Repeat find" },
        [","] = { ",", desc = "Repeat find reverse" },
        ["гй"] = { "gj", desc = "Down display line (Cyrillic)" },
        ["гк"] = { "gk", desc = "Up display line (Cyrillic)" },
        ["г0"] = { "g0", desc = "Display line start (Cyrillic)" },
        ["г$"] = { "g$", desc = "Display line end (Cyrillic)" },
        ["г^"] = { "g^", desc = "Display line first non-blank (Cyrillic)" },
        ["г_"] = { "g_", desc = "Display line last non-blank (Cyrillic)" },
        ["ив"] = { "iw", desc = "Inner word (Cyrillic)" },
        ["ав"] = { "aw", desc = "A word (Cyrillic)" },
        ["иВ"] = { "iW", desc = "Inner WORD (Cyrillic)" },
        ["аВ"] = { "aW", desc = "A WORD (Cyrillic)" },
        ["ип"] = { "ip", desc = "Inner paragraph (Cyrillic)" },
        ["ап"] = { "ap", desc = "A paragraph (Cyrillic)" },
        ["ис"] = { "is", desc = "Inner sentence (Cyrillic)" },
        ["ас"] = { "as", desc = "A sentence (Cyrillic)" },
        ["ит"] = { "it", desc = "Inner tag (Cyrillic)" },
        ["ат"] = { "at", desc = "A tag (Cyrillic)" },
        ["иб"] = { "ib", desc = "Inner () block (Cyrillic)" },
        ["аб"] = { "ab", desc = "A () block (Cyrillic)" },
        ["иБ"] = { "iB", desc = "Inner {} block (Cyrillic)" },
        ["аБ"] = { "aB", desc = "A {} block (Cyrillic)" },
        ["и\""] = { "i\"", desc = "Inner double quotes (Cyrillic)" },
        ["а\""] = { "a\"", desc = "A double quotes (Cyrillic)" },
        ["и'"] = { "i'", desc = "Inner single quotes (Cyrillic)" },
        ["а'"] = { "a'", desc = "A single quotes (Cyrillic)" },
        ["и`"] = { "i`", desc = "Inner backticks (Cyrillic)" },
        ["а`"] = { "a`", desc = "A backticks (Cyrillic)" },
        ["и)"] = { "i)", desc = "Inner parentheses (Cyrillic)" },
        ["а)"] = { "a)", desc = "A parentheses (Cyrillic)" },
        ["и]"] = { "i]", desc = "Inner brackets (Cyrillic)" },
        ["а]"] = { "a]", desc = "A brackets (Cyrillic)" },
        ["и}"] = { "i}", desc = "Inner braces (Cyrillic)" },
        ["а}"] = { "a}", desc = "A braces (Cyrillic)" },
        ["и>"] = { "i>", desc = "Inner angle brackets (Cyrillic)" },
        ["а>"] = { "a>", desc = "A angle brackets (Cyrillic)" },

        -- ["<Leader>hr"] = {
        --   function() require("hex2rgb").replace_hex_with_rgb() end,
        --   desc = "Replace hex with RGB",
        -- },
        ["<Leader>fv"] = {
          vim.cmd.LaravelConvertRules,
          desc = "Convert Laravel pipe validation rules to array syntax",
        },
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
      o = {
        ["х"] = { "h", desc = "Left (Cyrillic)" },
        ["й"] = { "j", desc = "Down (Cyrillic)" },
        ["к"] = { "k", desc = "Up (Cyrillic)" },
        ["л"] = { "l", desc = "Right (Cyrillic)" },
        ["Х"] = { "H", desc = "Top of screen (Cyrillic)" },
        ["М"] = { "M", desc = "Middle of screen (Cyrillic)" },
        ["Л"] = { "L", desc = "Bottom of screen (Cyrillic)" },
        ["в"] = { "w", desc = "Next word (Cyrillic)" },
        ["б"] = { "b", desc = "Previous word (Cyrillic)" },
        ["е"] = { "e", desc = "End of word (Cyrillic)" },
        ["В"] = { "W", desc = "Next WORD (Cyrillic)" },
        ["Б"] = { "B", desc = "Previous WORD (Cyrillic)" },
        ["Е"] = { "E", desc = "End of WORD (Cyrillic)" },
        ["ге"] = { "ge", desc = "End of previous word (Cyrillic)" },
        ["гЕ"] = { "gE", desc = "End of previous WORD (Cyrillic)" },
        ["гг"] = { "gg", desc = "Top of file (Cyrillic)" },
        ["Г"] = { "G", desc = "Bottom of file (Cyrillic)" },
        ["ф"] = { "f", desc = "Find char forward (Cyrillic)" },
        ["Ф"] = { "F", desc = "Find char backward (Cyrillic)" },
        ["т"] = { "t", desc = "Till char forward (Cyrillic)" },
        ["Т"] = { "T", desc = "Till char backward (Cyrillic)" },
        ["н"] = { "n", desc = "Next search match (Cyrillic)" },
        ["Н"] = { "N", desc = "Previous search match (Cyrillic)" },
        ["г*"] = { "g*", desc = "Next partial match (Cyrillic)" },
        ["г#"] = { "g#", desc = "Previous partial match (Cyrillic)" },
        ["0"] = { "0", desc = "Line start" },
        ["^"] = { "^", desc = "First non-blank" },
        ["$"] = { "$", desc = "Line end" },
        ["+"] = { "+", desc = "Next line first non-blank" },
        ["-"] = { "-", desc = "Previous line first non-blank" },
        ["_"] = { "_", desc = "Line first non-blank (count aware)" },
        ["|"] = { "|", desc = "Go to column" },
        ["%"] = { "%", desc = "Matching pair" },
        ["("] = { "(", desc = "Previous sentence" },
        [")"] = { ")", desc = "Next sentence" },
        ["{"] = { "{", desc = "Previous paragraph" },
        ["}"] = { "}", desc = "Next paragraph" },
        [";"] = { ";", desc = "Repeat find" },
        [","] = { ",", desc = "Repeat find reverse" },
        ["гй"] = { "gj", desc = "Down display line (Cyrillic)" },
        ["гк"] = { "gk", desc = "Up display line (Cyrillic)" },
        ["г0"] = { "g0", desc = "Display line start (Cyrillic)" },
        ["г$"] = { "g$", desc = "Display line end (Cyrillic)" },
        ["г^"] = { "g^", desc = "Display line first non-blank (Cyrillic)" },
        ["г_"] = { "g_", desc = "Display line last non-blank (Cyrillic)" },
        ["ив"] = { "iw", desc = "Inner word (Cyrillic)" },
        ["ав"] = { "aw", desc = "A word (Cyrillic)" },
        ["иВ"] = { "iW", desc = "Inner WORD (Cyrillic)" },
        ["аВ"] = { "aW", desc = "A WORD (Cyrillic)" },
        ["ип"] = { "ip", desc = "Inner paragraph (Cyrillic)" },
        ["ап"] = { "ap", desc = "A paragraph (Cyrillic)" },
        ["ис"] = { "is", desc = "Inner sentence (Cyrillic)" },
        ["ас"] = { "as", desc = "A sentence (Cyrillic)" },
        ["ит"] = { "it", desc = "Inner tag (Cyrillic)" },
        ["ат"] = { "at", desc = "A tag (Cyrillic)" },
        ["иб"] = { "ib", desc = "Inner () block (Cyrillic)" },
        ["аб"] = { "ab", desc = "A () block (Cyrillic)" },
        ["иБ"] = { "iB", desc = "Inner {} block (Cyrillic)" },
        ["аБ"] = { "aB", desc = "A {} block (Cyrillic)" },
        ["и\""] = { "i\"", desc = "Inner double quotes (Cyrillic)" },
        ["а\""] = { "a\"", desc = "A double quotes (Cyrillic)" },
        ["и'"] = { "i'", desc = "Inner single quotes (Cyrillic)" },
        ["а'"] = { "a'", desc = "A single quotes (Cyrillic)" },
        ["и`"] = { "i`", desc = "Inner backticks (Cyrillic)" },
        ["а`"] = { "a`", desc = "A backticks (Cyrillic)" },
        ["и)"] = { "i)", desc = "Inner parentheses (Cyrillic)" },
        ["а)"] = { "a)", desc = "A parentheses (Cyrillic)" },
        ["и]"] = { "i]", desc = "Inner brackets (Cyrillic)" },
        ["а]"] = { "a]", desc = "A brackets (Cyrillic)" },
        ["и}"] = { "i}", desc = "Inner braces (Cyrillic)" },
        ["а}"] = { "a}", desc = "A braces (Cyrillic)" },
        ["и>"] = { "i>", desc = "Inner angle brackets (Cyrillic)" },
        ["а>"] = { "a>", desc = "A angle brackets (Cyrillic)" },
      },
    },
  },
}

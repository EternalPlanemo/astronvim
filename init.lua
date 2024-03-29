return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin",     -- remote to use
    channel = "stable",    -- "stable" or "nightly"
    version = "latest",    -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly",    -- branch name (NIGHTLY ONLY)
    commit = nil,          -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil,     -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false,  -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false,     -- automatically quit the current session after a successful update
    remotes = {            -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },
  -- Set colorscheme to use
  colorscheme = "edge",
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },
  lsp = {
    skip_setup = {
      "rust_analyzer",
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = false,    -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "blade",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 10000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
      filter = function(client)
        if vim.bo.filetype == "php" then
          return client.name ~= "intelephense"
        end

        return true
      end,
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "intelephense",
    },
  },
  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    local autocmd = vim.api.nvim_create_autocmd
    local augroup = vim.api.nvim_create_augroup
    local blade_group = augroup("blade", { clear = true })

    vim.filetype.add {
      pattern = {
        ["%*.blade.php"] = "blade"
      }
    }

    autocmd({ "BufNew", "BufEnter" }, {
      pattern = { "*.blade.php" },
      desc = "Set up blade_formatter and use html syntax highlighitng",
      group = blade_group,
      callback = function()
        vim.cmd("set filetype=blade")
        vim.cmd("set syntax=html")
      end
    })

    autocmd({ "BufNew", "BufEnter" }, {
      pattern = { "*.html.twig" },
      desc = "Set up blade_formatter and use html syntax highlighitng",
      group = blade_group,
      callback = function()
        vim.cmd("set syntax=html")
      end
    })

    autocmd({ "BufNew", "BufEnter" }, {
      pattern = { "firestore.rules" },
      desc = "Use the TS syntax highlighting for firestore.rules",
      callback = function()
        vim.cmd("set syntax=typescript")
      end
    })

    autocmd({ "BufNew", "BufEnter" }, {
      pattern = { ".env.*" },
      desc = "Add syntax to .env.testing .env.production and so on",
      callback = function()
        vim.cmd("set filetype=sh")
        vim.cmd("set syntax=sh")
      end
    })
  end,
}

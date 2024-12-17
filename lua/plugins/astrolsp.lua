-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      autoformat = false, -- enable or disable auto formatting on start
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = true, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = false, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
        "intelephense",
        "html",
      },
      timeout_ms = 5000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      clangd = { capabilities = { offsetEncoding = "utf-8" } },
      html = {
        filetypes = { "html", "php", "blade" },
      },
      tailwindcss = {
        filetypes = { "html", "blade", "javascriptreact", "typescriptreact" },
      },
      intelephense = {
        filetypes = { "php", "blade" },
        settings = {
          intelephense = {
            environment = {
              phpVersion = "8.2.0",
            },
            files = {
              maxSize = 5000000,
            },
            format = {
              enable = false,
            },
            stubs = {
              "imagick",
              "random",
              "amqp",
              "apache",
              "apcu",
              "bcmath",
              "bz2",
              "calendar",
              "cassandra",
              "com_dotnet",
              "Core",
              "couchbase",
              "crypto",
              "ctype",
              "cubrid",
              "curl",
              "date",
              "dba",
              "dom",
              "enchant",
              "Ev",
              "event",
              "exif",
              "fann",
              "FFI",
              "ffmpeg",
              "fileinfo",
              "filter",
              "fpm",
              "ftp",
              "gd",
              "gearman",
              "geoip",
              "geos",
              "gettext",
              "gmagick",
              "gmp",
              "gnupg",
              "grpc",
              "hash",
              "http",
              "ibm_db2",
              "iconv",
              "igbinary",
              "imagick",
              "imap",
              "inotify",
              "interbase",
              "intl",
              "json",
              "judy",
              "ldap",
              "leveldb",
              "libevent",
              "libsodium",
              "libxml",
              "lua",
              "mailparse",
              "mapscript",
              "mbstring",
              "mcrypt",
              "memcache",
              "memcached",
              "meminfo",
              "meta",
              "ming",
              "mongo",
              "mongodb",
              "mqseries",
              "msgpack",
              "mssql",
              "mysql",
              "mysql_xdevapi",
              "mysqli",
              "ncurses",
              "newrelic",
              "oauth",
              "oci8",
              "odbc",
              "openssl",
              "parallel",
              "Parle",
              "pcntl",
              "pcov",
              "pcre",
              "pdflib",
              "PDO",
              "pdo_ibm",
              "pdo_mysql",
              "pdo_pgsql",
              "pdo_sqlite",
              "pgsql",
              "Phar",
              "posix",
              "pspell",
              "pthreads",
              "radius",
              "rar",
              "rdkafka",
              "readline",
              "recode",
              "redis",
              "Reflection",
              "regex",
              "rrd",
              "SaxonC",
              "session",
              "shmop",
              "SimpleXML",
              "snmp",
              "soap",
              "sockets",
              "sodium",
              "solr",
              "SPL",
              "SplType",
              "SQLite",
              "sqlite3",
              "sqlsrv",
              "ssh2",
              "standard",
              "stomp",
              "suhosin",
              "superglobals",
              "svn",
              "sybase",
              "sync",
              "sysvmsg",
              "sysvsem",
              "sysvshm",
              "tidy",
              "tokenizer",
              "uopz",
              "uv",
              "v8js",
              "wddx",
              "win32service",
              "winbinder",
              "wincache",
              "wordpress",
              "xcache",
              "xdebug",
              "xhprof",
              "xml",
              "xmlreader",
              "xmlrpc",
              "xmlwriter",
              "xsl",
              "xxtea",
              "yaf",
              "yaml",
              "yar",
              "zend",
              "Zend OPcache",
              "ZendCache",
              "ZendDebugger",
              "ZendUtils",
              "zip",
              "zlib",
              "zmq",
              "zookeeper",
            },
          },
        },
      },
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_document_highlight = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/documentHighlight",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "CursorHold", "CursorHoldI" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Document Highlighting",
          callback = function() vim.lsp.buf.document_highlight() end,
        },
        {
          event = { "CursorMoved", "CursorMovedI", "BufLeave" },
          desc = "Document Highlighting Clear",
          callback = function() vim.lsp.buf.clear_references() end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        -- gD = {
        --   function() vim.lsp.buf.declaration() end,
        --   desc = "Declaration of current symbol",
        --   cond = "textDocument/declaration",
        -- },
        -- ["<Leader>uY"] = {
        --   function() require("astrolsp.toggles").buffer_semantic_tokens() end,
        --   desc = "Toggle LSP semantic highlight (buffer)",
        --   cond = function(client) return client.server_capabilities.semanticTokensProvider and vim.lsp.semantic_tokens end,
        -- },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(client, bufnr)
      local filetype = vim.bo[bufnr].filetype

      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
      if client.name == "intelephense" then client.capabilities.textDocument.formatting = nil end

      if client.name == "html" and filetype == "php" then client.server_capabilities.renameProvider = nil end
    end,
  },
}

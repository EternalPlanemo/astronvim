return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require "dap"

    -- Path to codelldb adapter installed by Mason
    local codelldb_path = vim.fn.stdpath "data" .. "/mason/packages/codelldb/extension/adapter/codelldb"

    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = codelldb_path,
        args = { "--port", "${port}" },
      },
    }

    dap.configurations.odin = {
      {
        name = "Build & Debug Odin Program",
        type = "codelldb",
        request = "launch",
        program = function()
          local exe_path = vim.fn.getcwd() .. "/debug"

          -- Automatically build before debugging
          vim.notify("Building Odin program...", vim.log.levels.INFO)
          local build_cmd = string.format("odin build . -debug -o:none -out:%s", exe_path)
          local result = vim.fn.system(build_cmd)

          if vim.v.shell_error ~= 0 then
            vim.notify("Build failed:\n" .. result, vim.log.levels.ERROR)
            return ""
          end

          vim.notify("Build successful", vim.log.levels.INFO)
          return exe_path
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        runInTerminal = true,
      },
    }
  end,
}

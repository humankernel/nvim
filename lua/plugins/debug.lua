return {
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "leoluz/nvim-dap-go", -- go
      "mfussenegger/nvim-dap-python",   -- python
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    keys = function() 
        local dap = require("dap")
        return {
            { "<space>b",   dap.toggle_breakpoint,  desc = "Toggle Breakpoint" },
            { "<space>gb",  dap.run_to_cursor,      desc = "Run to Cursor" },
            { "<F1>",       dap.continue,           desc = "Continue" },
            { "<F2>",       dap.step_into,          desc = "Step Into" },
            { "<F3>",       dap.step_over,          desc = "Step Over" },
            { "<F4>",       dap.step_out,           desc = "Step Out" },
            { "<F5>",       dap.step_back,          desc = "Step Back" },
            { "<F13>",      dap.restart,            desc = "Restart" },
            { "<space>?", 
              function() require("dapui").eval(nil, { enter = true }) end,
              desc = "Eval var under cursor"
            }
        }
    end,
    config = function()
      local dap = require "dap"
      local ui = require "dapui"

      -- adapters
      require("dapui").setup()
      require("dap-go").setup()
      dap.adapters.gdb = {
          type = "executable",
          command = "gdb",
          args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
      }
      dap.configurations.c = {
          {
              name = "Launch",
              type = "gdb",
              request = "launch",
              program = function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
              end,
              cwd = "${workspaceFolder}",
              stopAtBeginningOfMainSubprogram = false,
          },
          {
              name = "Select and attach to process",
              type = "gdb",
              request = "attach",
              program = function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
              end,
              pid = function() 
                  local name = vim.fn.input("Executable name (filter): ")
                  return require("dap.utils").pick_process({ filter = name })
              end,
              cwd = "${workspaceFolder}",
          },
          {
              name = "Attach to gdbserver :1234",
              type = "gdb",
              request = "attach",
              target = "localhost:1234",
              program = function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
              end,
              cwd = "${workspaceFolder}",
          }
      }
      require("dap-python").setup("uv")
      require('dap-python').test_runner = 'pytest'
      require("nvim-dap-virtual-text").setup()

      -- dap ui
      dap.listeners.before.attach.dapui_config = function() ui.open() end
      dap.listeners.before.launch.dapui_config = function() ui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() ui.close() end
      dap.listeners.before.event_exited.dapui_config = function() ui.close() end
    end,
  },
}

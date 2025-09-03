return {
    "mfussenegger/nvim-dap",
    lazy = true,
    cmd = { "DapContinue", "DapToggleBreakpoint", "DapStepOver", "DapStepInto", "DapStepOut" },
    dependencies = {
        { "rcarriga/nvim-dap-ui", lazy = true, event = "VeryLazy", config = function() require("dapui").setup() end, },
        {
            "theHamsta/nvim-dap-virtual-text",
            lazy = true,
            event = "VeryLazy",
            config = function() require("nvim-dap-virtual-text").setup() end,
        },
        { "leoluz/nvim-dap-go",   lazy = true, ft = "go",          config = function() require("dap-go").setup() end, },
        {
            "mfussenegger/nvim-dap-python",
            lazy = true,
            ft = "python",
            config = function()
                require("dap-python").setup("uv")
                require("dap-python").test_runner = "pytest"
            end,
        },
        "nvim-neotest/nvim-nio",
    },
    keys = function()
        local dap = require("dap")
        return {
            { "<space>b",  dap.toggle_breakpoint, desc = "Toggle Breakpoint" },
            { "<space>gb", dap.run_to_cursor,     desc = "Run to Cursor" },
            { "<F1>",      dap.continue,          desc = "Continue" },
            { "<F2>",      dap.step_into,         desc = "Step Into" },
            { "<F3>",      dap.step_over,         desc = "Step Over" },
            { "<F4>",      dap.step_out,          desc = "Step Out" },
            { "<F5>",      dap.step_back,         desc = "Step Back" },
            { "<F13>",     dap.restart,           desc = "Restart" },
            {
                "<space>?",
                function() require("dapui").eval(nil, { enter = true }) end,
                desc = "Eval var under cursor"
            }
        }
    end,
    config = function()
        local dap = require "dap"

        -- GDB adapter config
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

        -- UI listeners
        local ui = require("dapui")
        dap.listeners.before.attach.dapui_config = function() ui.open() end
        dap.listeners.before.launch.dapui_config = function() ui.open() end
        dap.listeners.before.event_terminated.dapui_config = function() ui.close() end
        dap.listeners.before.event_exited.dapui_config = function() ui.close() end
    end,
}

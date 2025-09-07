return {
    {
        "Shatur/neovim-ayu",
        lazy = true,
        event = "VimEnter",
        config = function()
            vim.cmd([[colorscheme ayu-dark]])
        end
    },

    {
        'saghen/blink.cmp',
        lazy = true,
        event = "InsertEnter",
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'default' },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            completion = { documentation = { auto_show = false } },
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" },
    },

    -- edit your filesystem like a buffer
    -- see `https://github.com/stevearc/oil.nvim`
    {
        "stevearc/oil.nvim",
        lazy = true,
        keys = { { "-", "<cmd>Oil<cr>", desc = "Open parent dir" } },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
            columns = { "icon" },
            default_file_explorer = true,
            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,
            view_options = {
                show_hidden = true,
                natural_order = true,
                is_always_hidden = function(name, _)
                    return name == '..' or name == '.git'
                end,
            },
            win_options = {
                wrap = true,
            }
        },
    },

    {
        'stevearc/conform.nvim',
        lazy = true,
        event = 'BufWritePre',
        ---@module 'conform'
        ---@type conform.SetupOpts
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                go = { "goimports", "gofmt" },
                python = { "ruff_format" },
                c = { "clang_format" },
                ["*"] = { "codespell" },
                ["_"] = { "trim_whitespace" },
                javascript = { "prettierd", "prettier", stop_after_first = true },
                typescript = { "prettierd", "prettier", stop_after_first = true },
            },
            format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
        },
    },

    -- Treesitter configurations and abstraction layer for Neovim.
    -- see `:help nvim-treesitter` or `https://github.com/nvim-treesitter/nvim-treesitter`
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = true,
        event = "BufReadPre",
        build = ":TSUpdate",
        ---@module 'nvim-treesitter'
        ---@type nvim-treesitter.SetupOpts
        opts = {
            ensure_installed = { "lua", "vim", "vimdoc" },
            auto_install = true,
            sync_install = false,
            indent = { enable = true },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<Enter>", -- set to `false` to disable one of the mappings
                    node_incremental = "<Enter>",
                    scope_incremental = false,
                    node_decremental = "<Backspace>",
                },
            },
        }
    },

    {
        "https://github.com/neovim/nvim-lspconfig",
        lazy = true,
        event = "BufReadPre"
    },

    -- Statusline
    {
        'echasnovski/mini.statusline',
        lazy = true,
        event = "BufWinEnter",
        version = false,
        opts = {}
    },

    -- WhichKey helps you remember your Neovim keymaps
    -- see `https://github.com/folke/which-key.nvim`
    {
        "folke/which-key.nvim",
        lazy = true,
        keys = {
            {
                "<leader>?",
                function() require("which-key").show({ global = false }) end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
        config = function()
            require("which-key").add({
                { '<leader>c', group = '[C]ode' },
                { '<leader>t', group = '[T]est' },
                { '<leader>d', group = '[D]ocument' },
                { '<leader>r', group = '[R]ename' },
                { '<leader>s', group = '[S]earch' },
                { '<leader>w', group = '[W]orkspace' },
            })
        end,
    },

    -- precognition discover motions
    -- {
    --     "tris203/precognition.nvim",
    --     event = "VeryLazy",
    --     opts = {}
    -- },

    -- https://github.com/folke/snacks.nvim
    {
        "folke/snacks.nvim",
        --priority = 1000,
        lazy = true,
        event = "BufReadPre",
        ---@type snacks.Config
        opts = {
            bigfile      = { enabled = true },
            dashboard    = { enabled = false },
            explorer     = { enabled = false },
            indent       = { enabled = true },
            input        = { enabled = true },  -- better vim.ui.input
            picker       = { enabled = true },  -- fzf
            notifier     = { enabled = true },
            quickfile    = { enabled = true },  -- nvim somefile.txt will render the file as quick as possible
            scope        = { enabled = true },
            scroll       = { enabled = false }, -- smooth scrolling
            statuscolumn = { enabled = true },
            words        = { enabled = true },
            terminal     = { enabled = false },
        },
    },

    {
        "kristijanhusak/vim-dadbod-ui",
        lazy = true,
        cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
        dependencies = {
            { "tpope/vim-dadbod",                     lazy = true },
            { "kristijanhusak/vim-dadbod-completion", ft = { 'sql', 'plsql' }, lazy = true },
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },

    -- competitest.nvim is a testcase manager and checker
    -- see: `https://github.com/xeluxee/competitest.nvim`
    -- {
    --     "xeluxee/competitest.nvim",
    --     lazy = true,
    --     event = "BufReadPre",
    --     dependencies = { "MunifTanjim/nui.nvim" },
    --     keys = {
    --         { "<leader>tr", ":CompetiTest run <CR>",             desc = "[T]est [R]un" },
    --         { "<leader>tn", ":CompetiTest add_testcase <CR>",    desc = "[T]est [A]dd", },
    --         { "<leader>td", ":CompetiTest delete_testcase <CR>", desc = "[T]est [D]elete", },
    --         { "<leader>te", ":CompetiTest edit_testcase <CR>",   desc = "[T]est [E]dit", },
    --     },
    --     opts = {},
    -- },
    -- Find, Filter, Preview, Pick. All lua, all the time.
    -- see `https://github.com/nvim-telescope/telescope.nvim`
    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        cmd = "Telescope",
        dependencies = {
            { "nvim-lua/plenary.nvim",                    lazy = true },
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
            { "nvim-telescope/telescope-frecency.nvim",   lazy = true },
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local telescope = require('telescope')
            local themes = require('telescope.themes')

            telescope.setup({
                pickers = { find_files = { theme = "dropdown", hidden = true } },
                extensions = {
                    ['ui-select'] = { themes.get_dropdown() },
                    frecency = {
                        default_workspace = 'CWD',
                        show_scores = true,
                        show_unindexed = true,
                        disable_devicons = false,
                        ignore_patterns = {
                            '*.git/*',
                            '*/tmp/*',
                            '*/lua-language-server/*',
                        },
                    },
                },
            })

            pcall(telescope.load_extension, 'fzf')
            pcall(telescope.load_extension, 'frecency')
            pcall(telescope.load_extension, 'lazy_plugins')
            pcall(telescope.load_extension, 'ui-select')
        end,
        keys = {
            { "<leader>sf", "<cmd>Telescope find_files<cr>",  desc = "[S]earch [F]iles" },
            { "<leader>s.", "<cmd>Telescope oldfiles<cr>",    desc = "[S]earch Recent Files" },
            { "<leader>sg", "<cmd>Telescope live_grep<cr>",   desc = "[S]earch [G]rep" },
            { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "[S]earch [D]iagnostics" },
            { "<leader>sr", "<cmd>Telescope resume<cr>",      desc = "[S]earch [R]esume" },
            { "<leader>sh", "<cmd>Telescope help_tags<cr>",   desc = "[S]earch [H]elp" },
            { "<leader>sk", "<cmd>Telescope keymaps<cr>",     desc = "[S]earch [K]eymaps" },
            { "<leader>ss", "<cmd>Telescope builtin<cr>",     desc = "[S]earch [S]elect Telescope" },
            { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "[S]earch [W]ord" },
            {
                "<leader>/",
                function()
                    require("telescope.builtin").current_buffer_fuzzy_find(
                        require('telescope.themes').get_dropdown({ winblend = 10, previewer = false })
                    )
                end,
                desc = "[/] Fuzzily search in current buffer",
            },
            {
                "<leader>s/",
                function()
                    require("telescope.builtin").live_grep({
                        grep_open_files = true,
                        prompt_title = "Live Grep in Open Files",
                    })
                end,
                desc = "[S]earch [/] in Open Files",
            },
            {
                "<leader>sn",
                function()
                    require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
                end,
                desc = "[S]earch [N]eovim files",
            },
        },
    },


    {
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

}

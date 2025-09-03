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
<<<<<<< HEAD
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
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
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
=======
        "tris203/precognition.nvim",
        enabled = false,
        event = "VeryLazy",
>>>>>>> 17ee31be95c11617ad171ed11852fd04428d7987
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
    {
        "xeluxee/competitest.nvim",
        lazy = true,
        event = "BufReadPre",
        dependencies = { "MunifTanjim/nui.nvim" },
        keys = {
            { "<leader>tr", ":CompetiTest run <CR>",             desc = "[T]est [R]un" },
            { "<leader>tn", ":CompetiTest add_testcase <CR>",    desc = "[T]est [A]dd", },
            { "<leader>td", ":CompetiTest delete_testcase <CR>", desc = "[T]est [D]elete", },
            { "<leader>te", ":CompetiTest edit_testcase <CR>",   desc = "[T]est [E]dit", },
        },
        opts = {},
    },
}

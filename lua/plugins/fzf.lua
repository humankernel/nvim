-- Find, Filter, Preview, Pick. All lua, all the time.
-- see `https://github.com/nvim-telescope/telescope.nvim`
return {
    'nvim-telescope/telescope.nvim', 
    lazy = true, 
    event = "VeryLazy",
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- significantly improve sorting performance
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        -- A telescope.nvim extension that offers intelligent prioritization when selecting files from your editing history.
        -- see `https://github.com/nvim-telescope/telescope-frecency.nvim`
        "nvim-telescope/telescope-frecency.nvim",
        "nvim-tree/nvim-web-devicons", -- requires a Nerd Font
        -- This plugin is also overriding dap internal ui, so running any dap command, which makes use of the internal ui, will result in a telescope prompt.
        -- see `https://github.com/nvim-telescope/telescope-dap.nvim`
        --"nvim-telescope/telescope-dap.nvim",
    },
    config = function (_, opts)
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
    keys = function() -- (:help telescope.builtin)
        local builtin = require('telescope.builtin')
        return {
            { '<leader>sf', builtin.find_files,  desc = '[S]earch [F]iles' },
            { '<leader>s.', builtin.oldfiles,    desc = '[S]earch Recent Files ("." for repeat)' },
            { '<leader>sg', builtin.live_grep,   desc = '[S]earch [G]rep' },
            { '<leader>sd', builtin.diagnostics, desc = '[S]earch [D]iagnostics' },
            { '<leader>sr', builtin.resume,      desc = '[S]earch [R]esume' },
            { '<leader>sh', builtin.help_tags,   desc = '[S]earch [H]elp' },
            { '<leader>sk', builtin.keymaps,     desc = '[S]earch [K]eymaps' },
            { '<leader>ss', builtin.builtin,     desc = '[S]earch [S]elect Telescope' },
            { '<leader>sw', builtin.grep_string, desc = '[S]earch [W]ord' },
            { 
                '<leader>/',
                function()
                    builtin.current_buffer_fuzzy_find(themes.get_dropdown { winblend = 10, previewer = false })
                end, 
                desc = '[/] Fuzzily search in current buffer' 
            },

            -- It's also possible to pass additional configuration options.
            -- see `:help telescope.builtin.live_grep()` for information about particular keys
            { 
                '<leader>s/', 
                function()
                    builtin.live_grep {
                        grep_open_files = true,
                        prompt_title = 'Live Grep in Open Files',
                    }
                end,  
                desc = '[S]earch [/] in Open Files' 
            },

            -- Shortcut for searching your Neovim configuration files
            { 
                '<leader>sn', 
                function()
                    builtin.find_files { cwd = vim.fn.stdpath 'config' }
                end,  
                desc = '[S]earch [N]eovim files' 
            }
        }
    end,
}

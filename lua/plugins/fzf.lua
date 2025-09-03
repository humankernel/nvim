-- Find, Filter, Preview, Pick. All lua, all the time.
-- see `https://github.com/nvim-telescope/telescope.nvim`
return {
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
}

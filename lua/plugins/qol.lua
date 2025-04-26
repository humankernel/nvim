-- https://github.com/folke/snacks.nvim
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        explorer = { enabled = false },
        indent = { enabled = true },
        input = { enabled = true },     -- better vim.ui.input
        picker = { enabled = true },    -- fzf
        notifier = { enabled = true },
        quickfile = { enabled = true }, -- nvim somefile.txt will render the file as quick as possible
        scope = { enabled = true },
        scroll = { enabled = true },    -- smooth scrolling
        statuscolumn = { enabled = true },
        words = { enabled = true },
        terminal = { enabled = true },
    },
}

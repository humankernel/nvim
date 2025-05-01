-- https://github.com/folke/snacks.nvim
return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = true,
    event = "VeryLazy",
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
}

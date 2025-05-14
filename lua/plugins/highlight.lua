-- Treesitter configurations and abstraction layer for Neovim.
-- see `:help nvim-treesitter` or `https://github.com/nvim-treesitter/nvim-treesitter`
return {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = "VeryLazy",
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
}

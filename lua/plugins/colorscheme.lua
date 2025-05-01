return {
    {
        "Shatur/neovim-ayu",
        enable = false,
        config = function()
            vim.cmd([[colorscheme ayu-dark]])
        end
    },
    { "sainnhe/gruvbox-material" },
    --{
    --    'JoshPorterDev/nvim-base16',
    --    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    --    priority = 1000, -- make sure to load this before all the other start plugins
    --    config = function()
    --        vim.cmd([[colorscheme base16-ayu-dark]])
    --    end,
    --},
}

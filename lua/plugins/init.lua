return {
    -- Statusline
    { 
        'echasnovski/mini.statusline', 
        lazy = true,
        event = "VeryLazy",
        version = false, 
        opts = {} 
    },

    -- WhichKey helps you remember your Neovim keymaps
    -- see `https://github.com/folke/which-key.nvim`
    {
        "folke/which-key.nvim",
        lazy = true,
        event = "VeryLazy",
        keys = {
            {
                "<leader>?",
                function() require("which-key").show({ global = false }) end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
        config = function()
            local wk = require("which-key")
            wk.add({
                { '<leader>c', group = '[C]ode' },
                { '<leader>t', group = '[T]est' },
                { '<leader>d', group = '[D]ocument' },
                { '<leader>r', group = '[R]ename' },
                { '<leader>s', group = '[S]earch' },
                { '<leader>w', group = '[W]orkspace' },
            })
        end,
    },

    -- Library of 40+ independent Lua modules improving overall nvim experience with minimal effort
    -- see `https://github.com/echasnovski/mini.nvim`
    --{
    --    'echasnovski/mini.nvim', version = '*',
    --    dependencies = {
    --        { 'echasnovski/mini.comment', version = '*' },
    --        { 'echasnovski/mini.cursorword', version = '*' },
    --        { 'echasnovski/mini.icons', version = false },
    --        { 'echasnovski/mini.hipatterns', version = '*' },
    --    },
    --    config = function ()
    --        require "mini.comment".setup()
    --        require "mini.cursorword".setup()
    --        require "mini.icons".setup({
    --            diagnostics = { error = '' }
    --        })
    --        require "mini.hipatterns".setup()
    --
    --            -- Simple and easy statusline.
    --            local statusline = require 'mini.statusline'
    --            statusline.setup { use_icons = vim.g.have_nerd_font }
    --            -- You can configure sections in the statusline by overriding their
    --            -- default behavior. For example, here we set the section for
    --            -- cursor location to LINE:COLUMN
    --            ---@diagnostic disable-next-line: duplicate-set-field
    --            statusline.section_location = function()
    --                return '%2l:%-2v'
    --            end
    --        end
    --    }
}

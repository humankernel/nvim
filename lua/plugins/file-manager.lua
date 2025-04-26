-- edit your filesystem like a buffer
-- see `https://github.com/stevearc/oil.nvim`
return {
    "stevearc/oil.nvim",
    lazy = false,
    event = "VimEnter",
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
    keys = {
        { "-", "<cmd>Oil<cr>", desc = "Open parent dir" },
    },
}

-- competitest.nvim is a testcase manager and checker
-- see: `https://github.com/xeluxee/competitest.nvim`
return {
    "xeluxee/competitest.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    keys = {
        { "<leader>tr", ":CompetiTest run <CR>", desc = "[T]est [R]un" },
        {
            "<leader>tn",
            ":CompetiTest add_testcase <CR>",
            desc = "[T]est [A]dd",
        },
        {
            "<leader>td",
            ":CompetiTest delete_testcase <CR>",
            desc = "[T]est [D]elete",
        },
        {
            "<leader>te",
            ":CompetiTest edit_testcase <CR>",
            desc = "[T]est [E]dit",
        },
    },
    opts = {},
}

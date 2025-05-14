return {
    'stevearc/conform.nvim',
    lazy = true,
    event = 'VeryLazy',
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
}

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- =========================
-- Options
-- See `:help vim.opt` or `:help option-list`
-- =========================

vim.opt.clipboard = "unnamedplus" -- use system clipboard
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.mouse = "a"               -- allow the mouse to be used in Nvim
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- UI config
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.cursorline = true     -- Highlight current line
vim.opt.splitbelow = true     -- Horizontal splits below
vim.opt.splitright = true     -- Vertical splits right
vim.opt.termguicolors = true  -- True color support
vim.opt.signcolumn = "yes"    -- Always show sign column

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.numberwidth = 4
vim.opt.expandtab = true
vim.opt.breakindent = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.wrap = false

vim.opt.backspace = { "start", "eol", "indent" }
vim.g.have_nerd_font = true
vim.opt.title = true
vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.inccommand = "split"

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Search
vim.opt.incsearch = true  -- make search act like search in modern browsers
vim.opt.hlsearch = false  -- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true  -- but make it case sensitive if an uppercase is entered
vim.opt.path:append { "**" }
vim.opt.wildignore:append { "*/node_modules/*" }

-- backup
vim.opt.backup = false      -- creates a backup file
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.swapfile = false    -- creates a swapfile
vim.opt.undofile = true     -- save undo history

-- Enable virtual diagnostic lines on current line
vim.diagnostic.config({ virtual_lines = { current_line = true } })



-- =========================
-- Keybindings
-- =========================
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>", { desc = "Source current file" })
vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>", { desc = "Save and source file" })
vim.keymap.set("n", "<leader>w", ":write<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":quit<CR>", { desc = "Quit window" })

-- Identation
vim.keymap.set("v", "<", "<gv", { desc = "Tab Right" })
vim.keymap.set("v", ">", ">gv", { desc = "Tab Left" })

-- Clipboard mappings (copy/paste system clipboard)
vim.keymap.set({ "n", "x", "o" }, "gy", "+y", { desc = "Copy to clipboard" })
vim.keymap.set({ "n", "x", "o" }, "gp", "+p", { desc = "Paste clipboard text" })

-- Window splits
vim.keymap.set("n", "\\", ":belowright split<CR>", { desc = "Horizontal split below" })
vim.keymap.set("n", "|", ":vsplit<CR>", { desc = "Vertical split right" })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

local job_id = 0
vim.keymap.set("n", "<space>st", function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 15)
    job_id = vim.bo.channel
end, { desc = "Open terminal in new split below with height 15" })


-- =========================
-- Autocommands
-- =========================

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Remember yanked text",
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight yanked text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("TermOpen", {
    desc = "Disable line numbers in terminal buffers",
    group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
    end,
})

-- Native completions
--vim.api.nvim_create_autocmd("LspAttach", {
--    callback = function(ev)
--        local client = vim.lsp.get_client_by_id(ev.data.client_id)
--        if client:supports_method("textDocument/completion") then
--            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--        end
--    end,
--})

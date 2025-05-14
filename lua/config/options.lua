-- Native completions
--vim.api.nvim_create_autocmd('LspAttach', {
--    callback = function(ev)
--        local client = vim.lsp.get_client_by_id(ev.data.client_id)
--        if client:supports_method('textDocument/completion') then
--            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--        end
--    end,
--})

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")

-- Enable virtual text
vim.diagnostic.config({ virtual_lines = { current_line = true } })
--vim.diagnostic.config({ virtual_text = true })

-- Keybindings
vim.keymap.set({ 'n', 'x', 'o' }, 'gy', '"+y', { desc = 'Copy to clipboard' })
vim.keymap.set({ 'n', 'x', 'o' }, 'gp', '"+p', { desc = 'Paste clipboard text' })

-- split
vim.keymap.set("n", "\\", ":split<CR>")
vim.keymap.set("n", "|", ":vsplit<CR>")
vim.keymap.set("n", "<leader>q", ":close<CR>")

-- See `:help mapleader`
-- `mapleader` and `maplocalleader` must run before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- See `:help vim.opt` or `:help option-list`
vim.opt.clipboard = 'unnamedplus' -- use system clipboard
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.mouse = 'a'               -- allow the mouse to be used in Nvim

-- encoding
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- UI config
vim.opt.number = true         -- set numbered lines
vim.opt.relativenumber = true -- set relative numbered lines`
vim.opt.cursorline = true     -- highlight current line
vim.opt.splitbelow = true     -- force all horizontal splits to go below current window
vim.opt.splitright = true     -- force all vertical splits to go to the right of current window
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"    -- always show the sign column, otherwise it would shift the text each time

-- Tab
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4     -- the number of spaces inserted for each indentation
vim.opt.numberwidth = 4    -- set number column width to 4
vim.opt.expandtab = true   -- convert tabs to spaces
vim.opt.breakindent = true -- wrap lines with indent
vim.opt.autoindent = true
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.smarttab = true
vim.opt.wrap = false       -- display lines as one long line
vim.opt.backspace = { "start", "eol", "indent" }

vim.g.have_nerd_font = true
vim.opt.title = true         -- use current buffer name as window title
vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 8        -- min number of screen lines to keep above and below the cursor.
vim.opt.sidescrolloff = 8    -- Makes sure there are always eight lines of context
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!

-- display certain whitespace characters in the editor.
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


-- autocmd
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function() 
        vim.highlight.on_yank()
    end
})

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })
vim.api.nvim_create_autocmd("TermOpen", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
    callback = function() 
        vim.opt.number = false 
        vim.opt.relativenumber= false
    end
})

local job_id = 0
vim.keymap.set("n", "<space>st", function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 15)
    job_id = vim.bo.channel
end)

vim.keymap.set("n", "<space>example", function()
    vim.fn.chansend(job_id, { "echo hi\r\n" })
end)

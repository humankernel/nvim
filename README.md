# NeoVIM

Just my Neovim dots

- fzf: `Telescope`
- highlight: `treesitter`
- plugin manager: `Lazy`
- colorscheme: `base16-ayu-dark`
- file manager: `Oil`
- lsp: 
    - `nvim-lspconfig`
    - language server installer: `mason`
- completion: `nvim-cmp`
- keybindings: `which-key`

## Requirements

- `git`, `curl`, `unzip`, `tar`, `gzip`: for lazy an & treesitter
- `cmake`: for telescope fzf native
- `ripgrep`, `fd`: for telescope
- `luarocks`: for installing lua plugins (Mason)

Note that mason.nvim will regularly shell out to external package managers, 
such as cargo and npm. Depending on your personal usage, some of these will 
also need to be installed. Refer to :checkhealth mason for a full list.

-- [[ Configure basic options ]]

vim.g.mapleader = ' '

vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.signcolumn = 'yes'

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.winborder = 'single'

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Highlight the line where the cursor is on
vim.o.scrolloff = 10

-- Show <tab> and trailing spaces
vim.o.list = true

vim.o.pumheight = 7
vim.o.pummaxwidth = 80

vim.diagnostic.config({
    virtual_text = true,
})

-- [[ Set up keymaps ]] See `:h vim.keymap.set()`, `:h mapping`, `:h keycodes`

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l')
vim.keymap.set({ 'n' }, '<A-h>', '<C-w>h')
vim.keymap.set({ 'n' }, '<A-j>', '<C-w>j')
vim.keymap.set({ 'n' }, '<A-k>', '<C-w>k')
vim.keymap.set({ 'n' }, '<A-l>', '<C-w>l')

vim.keymap.set({ 'n' }, '<leader>o', ':update<CR>:source<CR>')
vim.keymap.set({ 'n' }, '<leader>w', ':write<CR>')
vim.keymap.set({ 'n' }, '<leader>q', ':quit<CR>')
vim.keymap.set({ 'n' }, '<leader>tp', ':TypstPreview<CR>')
vim.keymap.set({ 'n' }, '<leader>te', ':LspTinymistExportPdf<CR>')



-- [[ Basic Auto commands ]].

-- Highlight when yanking (copying) text.
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Sync clipboard between OS and Neovim. Schedule the setting after `UiEnter` because it can
-- increase startup-time. Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
vim.api.nvim_create_autocmd('UIEnter', {
    callback = function()
        vim.o.clipboard = 'unnamedplus'
    end,
})

-- Don't continue comments with o and O
-- See: https://github.com/LazyVim/LazyVim/discussions/2184
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "*" },
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions - "o"
    end,
    desc = "Don't continue comments with o and O",
})



-- [[ Plugins ]]

vim.pack.add({
    { src = 'https://codeberg.org/andyg/leap.nvim' },
    { src = 'https://github.com/chomosuke/typst-preview.nvim' },
    { src = 'https://github.com/mason-org/mason.nvim' },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/nvim-mini/mini.files' },
    { src = 'https://github.com/nvim-mini/mini.pairs' },
    { src = 'https://github.com/nvim-mini/mini.pick' },
    { src = 'https://github.com/nvim-mini/mini.surround' },
    { src = 'https://github.com/saghen/blink.cmp' },
    { src = 'https://github.com/vague-theme/vague.nvim' },
})

vim.cmd.colorscheme('vague')

-- leap.nvim
vim.keymap.set({ 'n', 'x', 'o' }, '<leader>j', '<Plug>(leap)')
vim.keymap.set({ 'n' }, '<leader>J', '<Plug>(leap-from-window)')

-- mason.nvim
require('mason').setup()

-- mini.files
require('mini.files').setup()
vim.keymap.set({ 'n' }, '<leader>e', MiniFiles.open)

-- mini.pairs
require('mini.pairs').setup()

-- mini.pick
require('mini.pick').setup()
vim.keymap.set({ 'n' }, '<leader>f', ':Pick files<CR>')
vim.keymap.set({ 'n' }, '<leader>h', ':Pick help<CR>')
vim.keymap.set({ 'n' }, '<leader>/', ':Pick grep_live<CR>')
vim.keymap.set({ 'n' }, '<leader>b', ':Pick buffers<CR>')

-- mini.surround
require('mini.surround').setup()

-- blink.cmp
require('blink.cmp').setup({
    signature = {
        enabled = true
    }
})


-- [[ LSP ]]

vim.lsp.enable({
    'lua_ls',
    'gopls',
    'svelte',
    'tinymist',
    'clangd',
    'html',
    'emmet_ls',
    'ts_ls',
    'tailwindcss',
    'ruff',
    'basedpyright',
})

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            }
        }
    }
})

vim.keymap.set({ 'n' }, '<leader>lf', vim.lsp.buf.format)

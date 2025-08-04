vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autochdir = false
vim.o.number = true
vim.o.cursorline = true
vim.o.list = true
vim.o.listchars = "tab:| ,trail:▫"
vim.o.scrolloff = 4
vim.o.ttimeoutlen = 0
vim.o.timeout = false
vim.o.viewoptions = 'cursor,folds,slash,unix'
vim.o.wrap = true
vim.o.textwidth = 0
vim.o.indentexpr = ''
-- vim.o.formatoptions:remove('tc')
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.showmode = false
vim.o.ignorecase = true
vim.o.smartcase = true
-- vim.o.shortmess:append('c')
vim.o.inccommand = 'split'
vim.o.completeopt = 'longest,noinsert,menuone,noselect,preview'
-- vim.o.lazyredraw = true
-- vim.o.visualbell = true
vim.o.modeline = false
vim.o.updatetime = 100
vim.o.virtualedit = 'block'

local backupdir = vim.fn.stdpath('cache') ..'/backup'
local undodir = vim.fn.stdpath('cache') ..'/undo'
if vim.fn.isdirectory(backupdir) == 0 then
	vim.fn.mkdir(backupdir, "p", "0o700")
end
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p", "0o700")
end
vim.opt.backupdir = backupdir..',.'
vim.opt.directory = backupdir..',.'
if vim.fn.has('persistent_undo') then
    vim.opt.undofile = true
    vim.opt.undodir = undodir..',.'
end

vim.cmd("highlight link markdownError NONE")

vim.g.lsp_enable = false

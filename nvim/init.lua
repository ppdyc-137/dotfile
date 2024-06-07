local vim = vim
local set = vim.opt
local Plug = vim.fn['plug#']
local keyset = vim.keymap.set

-- ==================== Editor behavior ====================
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.autochdir = false
set.number = true
set.cursorline = true
set.list = true
set.listchars = {tab = '| ', trail = '▫'}
set.scrolloff = 4
set.ttimeoutlen = 0
set.timeout = false
set.viewoptions = 'cursor,folds,slash,unix'
set.wrap = true
set.textwidth = 0
set.indentexpr = ''
-- set.formatoptions:remove('tc')
set.splitright = true
set.splitbelow = true
set.showmode = false
set.ignorecase = true
set.smartcase = true
-- set.shortmess:append('c')
set.inccommand = 'split'
set.completeopt = 'longest,noinsert,menuone,noselect,preview'
-- set.lazyredraw = true
-- set.visualbell = true
backupdir = os.getenv("HOME") ..'/.tmp/nvim/backup'
undodir = os.getenv("HOME") ..'/.tmp/nvim/undo'
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
vim.opt.updatetime = 100
vim.opt.virtualedit = 'block'

-- ==================== Basic Mappings ====================
vim.g.mapleader = ' '

keyset('', '<LEADER><CR>', '<Cmd>noh<CR>', {noremap = true})

keyset('', 's', '<Nop>')
keyset('', 'q', '<Nop>')
keyset('', 'S', '<Cmd>w<CR>')
keyset('', 'Q', '<Cmd>q<CR>')
keyset('', 'W', '<Cmd>bdelete<CR>')

keyset('', 'J', '5j')
keyset('', 'K', '5k')
keyset('', 'H', '5h')
keyset('', 'L', '5l')

keyset('', '<LEADER>l', '<C-w>l')
keyset('', '<LEADER>h', '<C-w>h')
keyset('', '<LEADER>j', '<C-w>j')
keyset('', '<LEADER>k', '<C-w>k')

keyset('n', 'sl', function()
    vim.opt.splitright = true
    vim.cmd('vsplit')
end)
keyset('n', 'sh', function()
    vim.opt.splitright = false
    vim.cmd('vsplit')
end)
keyset('n', 'sj', function()
    vim.opt.splitbelow = true
    vim.cmd('split')
end)
keyset('n', 'sk', function()
    vim.opt.splitbelow = false
    vim.cmd('split')
end)


-- ==================== Install Plugins with Vim-Plug ====================
vim.call('plug#begin')

Plug 'ellisonleao/gruvbox.nvim'
Plug 'sainnhe/edge'

Plug 'vim-airline/vim-airline'

Plug 'ryanoasis/vim-devicons'

Plug('neoclide/coc.nvim', { ['branch'] = 'release' })

-- Plug 'github/copilot.vim'

Plug 'junegunn/vim-easy-align'

Plug 'tpope/vim-surround'

Plug 'gcmt/wildfire.vim'

Plug 'tpope/vim-commentary'

Plug 'mhinz/vim-startify'

Plug 'farmergreg/vim-lastplace'

Plug('akinsho/bufferline.nvim', { ['tag'] = '*' })

Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate'})

Plug 'nvim-lua/plenary.nvim'
Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.6' })
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' })

Plug 'natecraddock/workspaces.nvim'

vim.call('plug#end')

-- ======================= Colorscheme ============================
set.termguicolors = true
local function set_backgroud(bg)
    if bg == "light" then
        vim.o.background = 'light'
        vim.g.edge_better_performance = 1
        vim.cmd.colorscheme 'edge'
    else
        vim.o.background = 'dark'
        vim.cmd.colorscheme 'gruvbox'
    end
end

set_backgroud(os.getenv("THEME"))

-- ======================= coc ============================
-- Autocomplete
vim.g.coc_global_extensions = { 'coc-git', 'coc-marketplace'}

function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use `g[` and `g]` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "g[", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "g]", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gD", "<CMD>vsplit<CR><Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})


-- Use gh to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "gh", '<CMD>lua _G.show_docs()<CR>', {silent = true})

-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})

-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})

-- Formatting selected code
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})

-- Remap keys for apply refactor code actions.
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Remap <C-j> and <C-k> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true, expr = true}
keyset("n", "<C-j>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-j>"', opts)
keyset("n", "<C-k>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-k>"', opts)
keyset("i", "<C-j>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-k>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-j>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-j>"', opts)
keyset("v", "<C-k>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-k>"', opts)

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true}
-- Show all diagnostics
keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
-- Find symbol of current document
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
-- Search workspace symbols
keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)

keyset("n", "<A-o>", "<Cmd>CocCommand clangd.switchSourceHeader<CR>", opts)
-- coc-explorer
keyset("n", "tt", "<Cmd>CocCommand explorer --toggle<CR>")


-- ==================== EasyAlign ====================
-- Start interactive EasyAlign in visual mode (e.g. vipga)
keyset("x", "ga", "<Plug>(EasyAlign)")

-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
keyset("n", "ga", "<Plug>(EasyAlign)")


-- ==================== wildfire.vim ====================
vim.g.wildfire_objects = {"i'", 'i"', "i)", "i]", "i}", "ip", "it", "iw", "i>"}


-- ==================== startify ====================
vim.g.startify_bookmarks = {
    { v= "~/.config/nvim/init.lua"},
    { f= "~/.config/fish/config.fish"},
}
vim.g.startify_lists = {
       { type= 'files',     header= {'   MRU'}            },
       { type= 'bookmarks', header= {'   Bookmarks'}      },
}


-- ==================== bufferline ====================
require("bufferline").setup{
    options = {
        numbers = "ordinal",
        diagnostics = "coc",
        offsets = {
            {
                filetype = "coc-explorer",
                text = "File Explorer",
                text_align = "center",
                separator = true,
            }
        },
    }
}

keyset('n', '<LEADER>1', "<CMD>BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true })
keyset('n', '<LEADER>2', "<CMD>BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true })
keyset('n', '<LEADER>3', "<CMD>BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true })
keyset('n', '<LEADER>4', "<CMD>BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true })
keyset('n', '<LEADER>5', "<CMD>BufferLineGoToBuffer 5<CR>", { noremap = true, silent = true })
keyset('n', '<LEADER>6', "<CMD>BufferLineGoToBuffer 6<CR>", { noremap = true, silent = true })
keyset('n', '<LEADER>7', "<CMD>BufferLineGoToBuffer 7<CR>", { noremap = true, silent = true })
keyset('n', '<LEADER>8', "<CMD>BufferLineGoToBuffer 8<CR>", { noremap = true, silent = true })
keyset('n', '<LEADER>9', "<CMD>BufferLineGoToBuffer 9<CR>", { noremap = true, silent = true })
keyset('n', '<LEADER>0', "<CMD>BufferLineGoToBuffer 10<CR>", { noremap = true, silent = true })

-- ==================== telescope ====================
require('telescope').setup{
    defaults = {
        prompt_prefix = ' ',
        initial_mode = "normal",
        mappings = {
            n = {
                ["l"] = "select_default",
                ["q"] = "close",
            }
        }
    },
}
local builtin = require('telescope.builtin')
keyset('n', 'ff', builtin.find_files, {})
keyset('n', 'fg', builtin.live_grep, {})
keyset('n', 'fb', builtin.buffers, {})

-- ==================== treesitter ====================
require'nvim-treesitter.configs'.setup{highlight={enable=true}}

-- ==================== project ====================
require("workspaces").setup({
    hooks = {
        open = { "Telescope find_files" },
    }
})
require'telescope'.load_extension("workspaces")
keyset('n', '<C-p>', "<CMD>Telescope workspaces<CR>", { noremap = true, silent = true })

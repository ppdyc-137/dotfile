local vim = vim
local set = vim.o
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
set.listchars = "trail:▫"
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
set.modeline = false
set.updatetime = 100
set.virtualedit = 'block'

backupdir = os.getenv("HOME") ..'/.cache/nvim/backup'
undodir = os.getenv("HOME") ..'/.cache/nvim/undo'
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

-- ==================== Auto Commands ====================
local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- ==================== Basic Mappings ====================
vim.g.mapleader = ' '

-- Escape and Clear hlsearch"
keyset({ "i", "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  return "<esc>"
end, { expr = true })

keyset('', 's', '<Nop>')
keyset('', 'q', '<Nop>')
keyset('', 'S', '<Cmd>w<CR>')
keyset('', 'Q', '<Cmd>q<CR>')
keyset('', 'W', '<Cmd>bdelete<CR>')

keyset("n", "<leader>K", "<cmd>norm! K<cr>")

keyset('', 'J', '5j')
keyset('', 'K', '5k')
keyset('', 'H', '5h')
keyset('', 'L', '5l')

keyset('', '<LEADER>l', '<C-w>l')
keyset('', '<LEADER>h', '<C-w>h')
keyset('', '<LEADER>j', '<C-w>j')
keyset('', '<LEADER>k', '<C-w>k')

keyset('', '<C-h>', '<CMD>bprevious<CR>', {noremap = true})
keyset('', '<C-l>', '<CMD>bnext<CR>', {noremap = true})

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

Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'

Plug('akinsho/bufferline.nvim', { ['tag'] = '*' })

Plug 'folke/snacks.nvim'

Plug('neoclide/coc.nvim', { ['branch'] = 'release' })

Plug 'github/copilot.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim'

Plug 'gcmt/wildfire.vim'

Plug 'farmergreg/vim-lastplace'

Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate'})

Plug 'MeanderingProgrammer/render-markdown.nvim'

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


-- ======================= airline ============================
require('lualine').setup {
  options = {
    theme = 'auto',
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}

-- ======================= bufferline ============================
require("bufferline").setup {
    options = {
        always_show_bufferline = false,
    }
}

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
-- Format all
keyset("n", "<leader>F", "<CMD>call CocAction('format')<CR>", {silent = true})

-- Apply the most preferred quickfix action on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", {silent = true, nowait = true})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})
-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Remap <C-j> and <C-k> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true, expr = true}
keyset("n", "<C-j>", 'coc#float#has_scroll() ? coc#float#scroll(1) : ""', opts)
keyset("n", "<C-k>", 'coc#float#has_scroll() ? coc#float#scroll(0) : ""', opts)
keyset("i", "<C-j>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : ""', opts)
keyset("i", "<C-k>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : ""', opts)
keyset("v", "<C-j>", 'coc#float#has_scroll() ? coc#float#scroll(1) : ""', opts)
keyset("v", "<C-k>", 'coc#float#has_scroll() ? coc#float#scroll(0) : ""', opts)

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true}
-- Show all diagnostics
keyset("n", "<space>d", ":<C-u>CocList diagnostics<cr>", opts)
-- Find symbol of current document
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
-- Search workspace symbols
keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)

keyset("n", "<A-o>", "<Cmd>CocCommand clangd.switchSourceHeader<CR>", opts)


-- ==================== wildfire.vim ====================
vim.g.wildfire_objects = {"i'", 'i"', "i)", "i]", "i}", "ip", "it", "iw", "i>"}

-- ==================== treesitter ====================
require'nvim-treesitter.configs'.setup{highlight={enable=true}}

-- ==================== copilot ====================
vim.g.copilot_filetypes = { ['*'] = false, }
keyset('i', "<M-i>", "<Plug>(copilot-suggest)", { silent = true })
require("CopilotChat").setup{
    highlight_headers = false,
    separator = '---',
    error_header = '> [!ERROR] Error',
    window = {
        layout = 'vertical',
        width = 0.4,
    },
    model = 'claude-3.5-sonnet',
}
keyset({ 'n', 'x' }, "<LEADER>a", "<CMD>CopilotChat<CR>", { silent = true })

-- ======================= snacks.nvim ============================
require("snacks").setup {
    indent = { enabled = true },
    terminal = {
        enabled = true,
        win = {
            style = 'minimal'
        }
    },
    lazygit = { enabled = true },
    zen = { enabled = true },
    toggle = {
        map = vim.keymap.set,
        which_key = false,
        notify = false,
    },
    dashboard = {
        preset = {
           keys = {
             { icon = " ", key = "<space>", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
             { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
             { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
             { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
             { icon = " ", key = "q", desc = "Quit", action = ":qa" },
           },
         },
        sections = {
            { section = "header", },
            { title = "Keymaps", icon = " ", padding = 1 },
            { section = "keys", gap = 1, padding = 1, indent = 2 },
            { title = "Configs", icon = " ", padding = 1 },
            {
                gap = 1, padding = 1, indent = 2,
                {
                    key = 'v',
                    desc = 'Neovim',
                    icon = " ",
                    action = ":e ~/.config/nvim/init.lua",
                },
                {
                    key = 'f',
                    desc = 'Fish',
                    icon = "󰈺 ",
                    action = ":e ~/.config/fish/config.fish",
                },
                {
                    key = 'h',
                    desc = 'Hyprland',
                    icon = " ",
                    action = ":e ~/.config/hypr/hyprland.conf",
                },
                {
                    key = 't',
                    desc = 'Kitty',
                    icon = " ",
                    action = ":e ~/.config/kitty/kitty.conf",
                },
            },
            -- {
            --   pane = 2,
            --   padding = 7,
            -- },
            -- { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1, limit = 8 },
            -- { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1, limit = 8 },
        },
    },
    image = {},
    picker = {
        focus = 'list',
        win = {
            list = {
                keys = {
                    ["l"] = "confirm",
                    ["K"] = "preview_scroll_up",
                    ["J"] = "preview_scroll_down",
                },
            },
        },
    },
}

function get_root()
    local folders = vim.g.WorkspaceFolders
    if folders and #folders > 0 then
        return folders[1]
    end
end

keyset('n', "<C-`>", function() 
    local root = get_root()
    Snacks.terminal(nil, { cwd = get_root() })
end)
keyset("t", "<C-`>", "<cmd>close<cr>")

keyset("n", "<leader>gg", function() Snacks.lazygit() end)
Snacks.toggle.zen():map("<leader>z")

keyset('n', 'ff', Snacks.picker.files, {})
keyset('n', 'fF', function()
    Snacks.picker.files( { cwd = get_root() } )
end)
keyset('n', 'fg', Snacks.picker.grep, {})
keyset('n', 'fG', function()
    Snacks.picker.grep( { cwd = get_root() } )
end)
-- ==================== render-markdown ====================
require('render-markdown').setup({
  file_types = { 'markdown', 'copilot-chat' },
})

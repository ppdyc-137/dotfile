" ==================== Auto load for first time uses ====================
if empty(glob($HOME.'/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:nvim_plugins_installation_completed=1
if empty(glob($HOME.'/.local/share/nvim/plugged/wildfire.vim/autoload/wildfire.vim'))
	let g:nvim_plugins_installation_completed=0
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ==================== Editor behavior ====================
"set clipboard=unnamedplus
let &t_ut=''
set autochdir
set exrc
set secure
set number
set cursorline
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set list
set listchars=tab:\|\ ,trail:▫
set scrolloff=4
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set wrap
set tw=0
set indentexpr=
set foldmethod=indent
set foldlevel=99
set foldenable
set formatoptions-=tc
set splitright
set splitbelow
set noshowmode
set ignorecase
set smartcase
set shortmess+=c
set inccommand=split
set completeopt=longest,noinsert,menuone,noselect,preview
set lazyredraw
set visualbell
silent !mkdir -p $HOME/.config/nvim/tmp/backup
silent !mkdir -p $HOME/.config/nvim/tmp/undo
"silent !mkdir -p $HOME/.config/nvim/tmp/sessions
set backupdir=$HOME/.config/nvim/tmp/backup,.
set directory=$HOME/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=$HOME/.config/nvim/tmp/undo,.
endif
" set colorcolumn=100
set updatetime=100
set virtualedit=block

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" ==================== Basic Mappings ====================
let mapleader=' '

noremap <LEADER><CR> :noh<CR>

map s :<nop>
map S :w<CR>
map Q :q<CR>
" map R :source $MYVIMRC<CR>

map J 5j
map K 5k
map H 5h
map L 5l

" split
map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sj :set splitbelow<CR>:split<CR>
map sk :set nosplitbelow<CR>:split<CR>

map <LEADER>l <C-w>l
map <LEADER>h <C-w>h
map <LEADER>j <C-w>j
map <LEADER>k <C-w>k

map <up> :res+5<CR>
map <down> :res-5<CR>
map <left> :vertical res-5<CR>
map <right> :vertical res+5<CR>

" Copy to system clipboard
vnoremap Y "+y

" Opening a terminal window
noremap <LEADER>t :vsplit<CR>:term<CR>

" tabe
" map <C-n> :tabe<CR>
" map <C-j> :tabnext<CR>
" map <C-k> :-tabnext<CR>

" run
" Compile function
noremap r :call CompileRun()<CR>
func! CompileRun()
	exec "w"
	if &filetype == 'c'
		:sp
		:res-10
		:term gcc % -o %< && ./%< && rm ./%<
	elseif &filetype == 'cpp'
		:sp
		:res-10
		:term g++ -std=c++11 % -Wall -o %< && ./%< && rm ./%<
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		:sp
		:res-10
		:term python3 %
	elseif &filetype == 'javascript'
		:sp
		:res-10
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	endif
endfunc

" inoremap ( ()<ESC>i
" inoremap [ []<ESC>i
" inoremap { {}<ESC>i
" inoremap < <><ESC>i
" inoremap " ""<ESC>i
" inoremap ' ''ESC>i

" ==================== Install Plugins with Vim-Plug ====================
call plug#begin()

" colorscheme
Plug 'morhetz/gruvbox'

" statusline
Plug 'vim-airline/vim-airline'

" icons
Plug 'ryanoasis/vim-devicons'

" auto complete
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'junegunn/vim-easy-align'

Plug 'liuchengxu/vista.vim'

Plug 'tpope/vim-surround'

Plug 'gcmt/wildfire.vim'

Plug 'nvim-treesitter/nvim-treesitter'

Plug 'tpope/vim-commentary'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

Plug 'ggandor/leap.nvim'

Plug 'mhinz/vim-startify'
call plug#end()


" ==================== gruvbox ====================
let g:gruvbox_transparent_bg = '1'
autocmd vimenter * ++nested colorscheme gruvbox
autocmd VimEnter * hi Normal ctermbg=none
set background=dark


" ==================== coc ====================
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
" set signcolumn=yes

let g:coc_global_extensions = [
	\ 'coc-git',
	\ 'coc-json',
	\ 'coc-yank',
	\ 'coc-vimlsp',
	\ 'coc-explorer',
	\ 'coc-marketplace'
	\]

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
inoremap <silent><expr> <C-SPACE> coc#refresh()


" navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>+ <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Show Documentation
nnoremap <silent> gh :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
	else
		call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" coc-yank
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" coc-explorer
nmap tt <Cmd>CocCommand explorer --toggle<CR>


" ==================== FZF ====================
let g:fzf_preview_window = 'right:40%'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

command! BD call fzf#run(fzf#wrap({
  \ 'options': '--multi --reverse'
\ }))

noremap <c-d> :BD<CR>

let g:fzf_layout = { 'window': { 'width': 0.75, 'height': 0.75 } }


" ==================== EasyAlign ====================
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlig)


" ==================== Vista.vim ====================
nmap tv :Vista!!<CR>
let g:vista#renderer#enable_icon = 1


" ==================== wildfire.vim ====================
let g:wildfire_objects = ["i'", 'i"', "i)", "i]", "i}", "ip", "it", "iw", "i>"]


" ==================== nvim-treesitter ====================
if g:nvim_plugins_installation_completed == 1
lua <<EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = {"c", "cpp", "python", "bash"},
	highlight = {
		enable = true,
	},
	indent = {
		enable = true
	}
}
EOF
endif


" ==================== markdown-preview ====================
let g:mkdp_browser = '/usr/bin/google-chrome-stable'
function OpenMarkdownPreview (url)
  execute "silent ! google-chrome-stable --new-window " . a:url
endfunction
let g:mkdp_browserfunc = 'OpenMarkdownPreview'


" ==================== startify ====================
let g:startify_bookmarks = [{'v' : "~/.config/nvim/init.vim"}, {'i' : "~/.config/i3/config"}]
let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ ]

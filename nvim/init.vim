" ==================== Auto load for first time uses ====================
if empty(glob($HOME.'/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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
set tabstop=2
set shiftwidth=2
set softtabstop=2
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
set colorcolumn=100
set updatetime=100
set virtualedit=block

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" ==================== Basic Mappings ====================
let mapleader=' '

noremap <LEADER><CR> :noh<CR>

map s :<nop>
map S :w<CR>
map Q :q<CR>
map R :source $MYVIMRC<CR>

map J 5j
map K 5k

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

" tabe
map <C-n> :tabe<CR>
map <C-j> :tabnext<CR>
map <C-k> :-tabnext<CR>


" ==================== Install Plugins with Vim-Plug ====================
call plug#begin()

" colorscheme
Plug 'morhetz/gruvbox'

" statusline
Plug 'vim-airline/vim-airline'

" File explorer
Plug 'preservim/nerdtree'

" class outline viewer
Plug 'preservim/tagbar', { 'on': 'TagbarToggle' }

call plug#end()


" gruvbox
let g:gruvbox_transparent_bg = '1'
autocmd vimenter * ++nested colorscheme gruvbox
autocmd VimEnter * hi Normal ctermbg=none
set background=dark


" NERDTree
noremap tn :NERDTreeToggle<CR>

" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif


" TagbarToggle
nmap tt :TagbarToggle<CR>


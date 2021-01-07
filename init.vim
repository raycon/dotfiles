"  _       _ _         _           
" (_)_ __ (_) |___   _(_)_ __ ___  
" | | '_ \| | __\ \ / / | '_ ` _ \ 
" | | | | | | |_ \ V /| | | | | | |
" |_|_| |_|_|\__(_)_/ |_|_| |_| |_|
"
"  by raegon@gmail.com

"-------------------------------------------------------------------------------
" Remap for easy edit 
"-------------------------------------------------------------------------------

nmap <silent> ,ev :e  $MYVIMRC<CR>
autocmd! bufwritepost $MYVIMRC source $MYVIMRC
autocmd! bufleave echo $MYVIMRC

" leader
let mapleader = ","

"-------------------------------------------------------------------------------
" vim-plug
"-------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')

" Apperance
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'

" Behavior
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-obsession'

" File
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'raimondi/delimitmate'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'Yggdroot/indentLine'

" IDE
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntax
Plug 'kevinoid/vim-jsonc'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components'

call plug#end()

"-------------------------------------------------------------------------------
" PLUGIN SETTINGS
"-------------------------------------------------------------------------------

" Color ------------------------------------------------------------------------

if (has("termguicolors"))
    set termguicolors
endif

colorscheme onedark

" transparent bg
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE

" NERDTree ---------------------------------------------------------------------

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

let g:NERDTreeWinSize=35

" EasyMotion -------------------------------------------------------------------

let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1  " Turn on case-insensitive feature

" Airline ----------------------------------------------------------------------

let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" fzf --------------------------------------------------------------------------

" Define Rg
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" COC --------------------------------------------------------------------------

source ~/dotfiles/coc.vim

let g:coc_global_extensions=['coc-json', 'coc-css', 'coc-tsserver', 'coc-flow', 'coc-prettier', 'coc-eslint' ]

"-------------------------------------------------------------------------------
" GLOBAL SETTINGS
"-------------------------------------------------------------------------------

" Line paddings to cursor
set so=10

" width
set textwidth=80

" Space and Tab     " Use 4 spaces instead of tab
set tabstop=2       " Column counts for tab
set shiftwidth=2    " Column counts for <<, >>
set softtabstop=2   " Space count for tab key in INSERT mode
set expandtab       " Use spaces instead of tabs
set breakindent     " Every wrapped line will continue visually indented

" Search
set wrapscan        " Search wrap lines
set ignorecase      " Search ignore case
set smartcase       " /foo matches FOO and fOo, but /FOO only matches the former
set hlsearch        " Enable search highlighting

" Any buffer can be hidden (keeping its changes) without write
set hidden

" Turn backup off, since most stuff is in git
set nobackup
set nowritebackup
set noswapfile

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Change keyboard layout to english in normal mode
set noimdisable
set iminsert=1
set imsearch=-1

" foo-bar as word
set iskeyword+=-

" Using the clipboard as the default register
set clipboard=unnamedplus

" Mouse
set mouse=n

"-------------------------------------------------------------------------------
" KEY MAPPING
"-------------------------------------------------------------------------------

" j and k move around wrapped line
map j gj
map k gk

" Yank all
nmap ya :%y+<CR>

" Move lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Buffer
nmap <silent> <A-p> :bp<CR>
nmap <silent> <A-n> :bn<CR>
nmap <silent> <C-A-n> :tabnext<CR>
nmap <silent> <C-A-p> :tabprev<CR>

" Plugin ----------------------------------------------------------------------

" vim-plug
nmap <leader>pi :PlugInstall<CR>
nmap <leader>pc :PlugClean<CR>
nmap <leader>pu :PlugUpdate<CR>

" NERDTree
nmap <silent> <F2> :NERDTreeToggle<CR>
nmap <silent> <S-F2> :NERDTreeFind<CR>

" EasyMotion
nmap f <Plug>(easymotion-overwin-f2)

" fzf
nmap <c-e> :History<cr>
nmap <a-e> :Buffers<cr>
nnoremap <expr> <C-n> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"
nnoremap <C-g> :Rg<CR>

" Comment
nmap <c-_> <S-v>gcgv<esc>
vmap <c-_> gcgv<esc>

" Toggle ----------------------------------------------------------------------

nmap <silent> <leader>th :setlocal hlsearch! hlsearch?<CR>
nmap <silent> <leader>tw :setlocal wrap!<CR>:setlocal wrap?<CR>
nmap <silent> <leader>tn :setlocal number!<CR>
nmap <silent> <leader>tp :setlocal invpaste paste?<CR>
nmap <silent> <leader>tb <Plug>MarkdownPreviewToggle
nmap <silent> <leader>ti :IndentLinesToggle<CR>


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

" leader
let mapleader = ","

nmap <silent> <leader>ev :e  $MYVIMRC<CR>
nmap <silent> <leader>ec :e  ~/dotfiles/coc.vim<CR>
nmap <silent> <leader>so :source $MYVIMRC<CR>

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
Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdtree' |
  \ Plug 'Xuyuanp/nerdtree-git-plugin' |
  \ Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
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
Plug 'liuchengxu/vista.vim'

" Syntax
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

syntax on
colorscheme onedark

hi link jsModuleKeyword Identifier
hi link jsxComponentName Identifier
hi link jsxBraces Operator
hi link jsClassDefinition Identifier
hi link jsFlowObjectKey Identifier
hi Comment gui=italic

let g:onedark_terminal_italics=1

" Italic

" set t_ZH=[3m
" set t_ZR=[23m

" transparent bg
" autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE

" NERDTree ---------------------------------------------------------------------

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

let g:NERDTreeWinSize=35
let g:NERDTreeShowHidden=1
let g:NERDTreeIgnore=['\.git$']

" EasyMotion -------------------------------------------------------------------

let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1  " Turn on case-insensitive feature

" Airline ----------------------------------------------------------------------

let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'jsformatter'

" fzf --------------------------------------------------------------------------

" Define Rg
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'

" COC --------------------------------------------------------------------------

source ~/dotfiles/coc.vim

let g:coc_global_extensions=['coc-json', 'coc-css', 'coc-tsserver', 'coc-flow', 'coc-prettier', 'coc-eslint' ]

" Polyglot ---------------------------------------------------------------------

let g:javascript_plugin_flow = 1

" Vista ------------------------------------------------------------------------

let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'coc'
let g:vista_fzf_preview = ['right:50%']

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

" Fix typing mistakes
command! Vs vs

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

" Update
nmap <silent> <leader>w :update<CR>

" Syntax ----------------------------------------------------------------------

function! Pad(s,amt)
    return a:s . repeat(' ',a:amt - len(a:s))
endfunction

function! SynStack ()
    for item in synstack(line("."), col("."))
        let gid = synIDtrans(item)
        let sname = synIDattr(item, "name")
        let gname = synIDattr(gid, "name")
        let fg = synIDattr(gid, "fg#")
        let bg = synIDattr(gid, "fg#")
        echo Pad(sname, 15)." -> ".Pad(gname, 15)." BG: ".Pad(bg,7)." FG: ".fg
    endfor
endfunction

map <silent> <leader>g :call SynStack()<CR>
map <silent> <leader>ht :so $VIMRUNTIME/syntax/hitest.vim<CR>

" Plugin ----------------------------------------------------------------------

" vim-plug
nmap <leader>pi :PlugInstall<CR>
nmap <leader>pc :PlugClean<CR>
nmap <leader>pu :PlugUpdate<CR>

" EasyMotion
nmap <space> <Plug>(easymotion-overwin-f)
map  <leader>/ <Plug>(easymotion-sn)
omap <leader>/ <Plug>(easymotion-tn)
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)

" fzf
nnoremap <expr> <C-n> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"
nnoremap <C-e> :History<cr>
nnoremap <A-e> :Buffers<cr>
nnoremap <C-g> :Rg<CR>

" Comment
nmap <c-_> <S-v>gcgv<esc>
vmap <c-_> gcgv<esc>

" Vista
nmap <c-t> :Vista finder<cr>

" Toggle ----------------------------------------------------------------------

nmap <silent> <leader>th :setlocal hlsearch! hlsearch?<CR>
nmap <silent> <leader>tw :setlocal wrap!<CR>:setlocal wrap?<CR>
nmap <silent> <leader>tn :setlocal number!<CR>
nmap <silent> <leader>tp :setlocal invpaste paste?<CR>
nmap <silent> <leader>tb <Plug>MarkdownPreviewToggle
nmap <silent> <leader>ti :IndentLinesToggle<CR>
nmap <silent> <leader>tt :NERDTreeToggle<CR>
nmap <silent> <leader>tf :NERDTreeFind<CR>
nmap <silent> <leader>tc :set cursorline!<CR>
nmap <silent> <leader>ta :AirlineToggle<CR>
nmap <silent> <leader>to :Vista!!<Cr>


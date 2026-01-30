set nocompatible              " required
filetype off                  " required

set mouse=a
set foldcolumn=3

" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
"Plugin 'gmarik/Vundle.vim'

" Plugin utilities
"Plugin 'tpope/vim-fugitive' " plugin on GitHub repo
""Plugin 'scrooloose/nerdtree' " file drawer, open with :NERDTreeToggle
"Plugin 'kien/ctrlp.vim' "fuzzy find files
""Plugin 'klen/python-mode' "python mode
"Plugin 'Valloric/YouCompleteMe' "YCM
""Plugin 'klen/python-mode' "python mode
"Plugin 'vim-airline/vim-airline' "airline
""Plugin 'jeffkreeftmeijer/vim-numbertoggle' "number-toggle


" All of your Plugins must be added before the following line
"call vundle#end()            " required

" Automatix reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" set a map leader for more key combo
let mapleader = ','

" Show preview of folded doc string
let g:SimpylFold_docstring_preview = 1

" generate tags
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Map
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" map <c-j> <c-w>j
" map <c-k> <c-w>k
" map <c-l> <c-w>l
" map <c-h> <c-w>h

" map sort function to a key
vnoremap <Leader>s :sort<CR>

" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
"vnoremap < <gv  " better indentation
"vnoremap > >gv  " better indentation
vnoremap <S-TAB> <gv  " better indentation
vnoremap <Tab> >gv  " better indentation

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``."
set pastetoggle=<F2>
set clipboard=unnamed

" Enable folding
set foldmethod=indent
set foldlevel=99

" Syntax highlighting
syntax on 
filetype plugin indent on

" line number on
set number

" Set a color column at 80
" set colorcolumn=80

" indentation 
set autoindent
set smartindent

" use 4 spaces instead of tabs during formatting
set tabstop=4 " the visible width of tabs
set softtabstop=4 " edit as if the tabs are 4 characters wide
set shiftwidth=4
set expandtab
set shiftround " round indent to a multiple of 'shiftwidth'

" show the satus line all the time
set laststatus=2 

" Set font size
set guifont=Monaco:h14

" set history and undo
set history=1000
set undolevels=1000

" search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Text width
set tw=100
set nowrap

" regex
set magic

"opening a new file when the current buffer has unsaved changes 
" causes files to be hidden instead of closed
set hidden

set wildmenu
set showcmd

" my color scheme
set background=dark
colorscheme nord

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" close NERDTree after a file is opened
let g:NERDTreeQuitOnOpen=0
" show hidden files in NERDTree
let NERDTreeShowHidden=1
" Toggle NERDTree
map <c-\> :NERDTreeToggle<cr>

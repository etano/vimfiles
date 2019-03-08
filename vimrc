let mapleader = "\<Space>" " leader
noremap ; $
xnoremap p pgvy

nnoremap <Leader>i :Files<CR>
nnoremap <Leader>o :GFiles<CR>
nnoremap <leader>f :Files <C-R>9<CR>
nnoremap <leader>h :History:<CR>
nnoremap <Leader>e :Buffers<CR>
nnoremap <Leader>t :Tags<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>u :GundoToggle<CR>
nnoremap <Leader>x :bd<CR>
nnoremap <Leader>q :q<CR>
noremap <S-h> b
noremap <S-j> }j
noremap <S-k> {k
noremap <S-l> e
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
inoremap <A-h> <C-o>h
inoremap <A-h> <C-o>j
inoremap <A-k> <C-o>k
inoremap <A-l> <C-o>l
inoremap <C-x> <Esc>

set nocompatible              " be iMproved, required
filetype off                  " required

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'hynek/vim-python-pep8-indent'
Plug 'spolu/dwm.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'arcticicestudio/nord-vim'
Plug 'etano/vim-snippets'
Plug 'scrooloose/syntastic'
Plug 'digitaltoad/vim-jade'
Plug 'sjl/gundo.vim'
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'terryma/vim-expand-region'
"Plug 'vim-scripts/gitignore'
Plug 'rhysd/vim-clang-format'
Plug 'posva/vim-vue'

" Initialize plugin system
call plug#end()

" All of your Plugins must be added before the following line
filetype plugin indent on    " required

" fzf
set rtp+=~/.fzf
imap <c-x><c-l> <plug>(fzf-complete-line)

"allow backspacing over everything in insert mode
set backspace=indent,eol,start
set t_kb=

set history=1000 "store lots of :cmdline history
set number      "show line numbers
set list "display tabs and trailing spaces
set listchars=tab:>~,trail:~,nbsp:~
set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default
set wrap        "dont wrap lines
set linebreak   "wrap lines at convenient points

if v:version >= 703
    "undo settings
    set undodir=~/.vim/undofiles
    set undofile

    set colorcolumn=+1 "mark the ideal max text width
endif
set colorcolumn=80

"default indent settings
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd BufRead,BufNewFile *.c,*.cc,*.cpp,*.h,*.hpp setlocal expandtab shiftwidth=4 softtabstop=4
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
set modeline

"Clang format settings
let g:clang_format#style_options = {
    \ "ColumnLimit": 0,
    \ "Standard": "C++11"}

"folding settings
set foldmethod=syntax   "fold based on indent
set foldnestmax=2       "deepest fold
"set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"turn on syntax highlighting
syntax on
au BufNewFile,BufRead *.in set filetype=c

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

"tell the term has 256 colors
set t_Co=256

"colors
syntax enable
set background=dark
"let g:solarized_termcolors=16
"colorscheme solarized
colorscheme nord

"paste toggle
" Toggle paste mode
" "   (prefer this over 'pastetoggle' to echo current state)
nmap <leader>p :setlocal paste! paste?<cr>

"hide buffers when not displayed
set hidden

""statusline setup
set laststatus=2

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

"visual search mappings
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'svn\|commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

"spell check when writing commit logs or latex
autocmd filetype svn,*commit*,tex setlocal spell

"spell check
set spelllang=en
set spellfile=$HOME/.vim/spell/en.utf-8.add

"code search
command! -bang -nargs=* CodeSearch
  \ call fzf#vim#ag_raw(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
autocmd! BufEnter * py3 set_project_root()
nmap <leader>1 viw"8y:CodeSearch! "<C-R>8"

"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_quiet_messages = { "type": "style" }
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 '
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute " ,"trimming empty <", "unescaped &" , "lacks \"action", "is not recognized!", "discarding unexpected"]
let g:syntastic_html_tidy_quiet_messages = { "level" : "warnings" }


" Get root of the project by finding a .git folder
python3 <<EOF

import vim
import os
import time

def set_project_root():
    current_buffer_path = vim.current.buffer.name
    found_root_directory = False

    # Set the search directory to the current file in case we can not find the
    # parent directory
    parent_directory = current_buffer_path

    while current_buffer_path and current_buffer_path != '/':
        current_buffer_path, _ = os.path.split(current_buffer_path)

        try:
            d = os.listdir(current_buffer_path)
        except Exception:
            continue
        else:
            if '.git' in os.listdir(current_buffer_path):
                found_root_directory = True
                parent_directory = current_buffer_path
                break

    vim.command('let @9="{}"'.format(parent_directory))
    return parent_directory
EOF

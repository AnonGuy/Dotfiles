"                            vim:foldmethod=marker
"                  ~ https://github.com/AnonGuy/Dotfiles ~

let g:indentLine_enabled = 0

" General Options {{{
set nowrap
set hidden
set nospell
set mouse=a
set nobackup
set smartcase
set noshowmode
set splitright
set splitbelow
set guicursor=
set foldlevel=99
set shortmess+=c
set nowritebackup
set termguicolors

set signcolumn=no
set conceallevel=0
set updatetime=300
set updatetime=500
set encoding=utf-8
set laststatus=2 ruler
set number norelativenumber

" Resize window ratios automagically
autocmd VimResized * wincmd =

" Disable some things on terminal windows
autocmd TermOpen * set nonu
autocmd TermOpen * set signcolumn=no
autocmd TermOpen * let g:indentLine_enabled = 0

" Tab Configuration
set softtabstop=2 tabstop=2 shiftwidth=2 expandtab
autocmd Filetype python setlocal ts=4 sw=4 sts=0
autocmd Filetype java setlocal ts=4 sw=4 sts=0
autocmd Filetype html setlocal ts=2 sw=2 sts=0
autocmd Filetype go setlocal ts=4 sw=4 sts=0
autocmd Filetype cs setlocal ts=4 sw=4 sts=0
autocmd FileType pdc set conceallevel=0
autocmd Filetype md set conceallevel=0
autocmd FileType zsh set foldlevel=0
autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
" }}}


" Keyboard Shortcuts and remaps {{{
nnoremap <space> za
nnoremap <C-Tab> :bn<CR>
nnoremap <C-S-Tab> :bp<CR>
nnoremap <C-g> :GitMessenger<CR>
nnoremap <Leader>h :Hexmode <CR>
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>

" Toggle search highlights
nnoremap <silent><expr> <Leader>h (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

" Toggle the NERDTree sidebar
map <F6> :NERDTreeToggle<CR>
" Toggle the ctags viewer
map <F7> :Tagbar<CR>
map <C-f> :CtrlP<CR>

set clipboard=unnamed,unnamedplus

" Escape out of nested term:// things
tnoremap <Esc> <C-\><C-n>

" FZF fuzzy tag finder
nnoremap <silent> <C-t> :Tags<CR>
" }}}


" Plugins {{{

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if &compatible
  set nocompatible
endif

call plug#begin()

Plug 'aurieh/discord.nvim'
Plug 'joshglendenning/vim-caddyfile'
Plug 'aghost-7/critiq.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'ap/vim-css-color'
Plug 'chenillen/jad.vim'
Plug 'aserebryakov/vim-todo-lists'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim'
Plug 'pseewald/vim-anyfold'
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'vim-python/python-syntax'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf',
Plug 'junegunn/fzf.vim'
Plug 'chr4/nginx.vim'
Plug 'Yggdroot/indentLine'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'wakatime/vim-wakatime'
Plug 'OmniSharp/omnisharp-vim'

call plug#end()

filetype plugin indent on
syntax enable

" }}}


" Appearance {{{
syntax on
let g:lightline = {'colorscheme': 'gruvbox'}
let g:gruvbox_contrast_dark='hard'

colorscheme gruvbox
set background=dark
" }}}


" Plugin Configuration {{{
filetype plugin indent on

" Git shouldn't start nested nvim instances
if has('nvim')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
endif

" Don't autosave/load default editing session
let g:session_autosave = 'no'
let g:session_autoload = 'no'

" NERDTree git plugin symbols
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "~",
    \ "Staged"    : "+",
    \ "Untracked" : "*",
    \ "Renamed"   : "r",
    \ "Unmerged"  : "u",
    \ "Deleted"   : "-",
    \ "Dirty"     : "~",
    \ "Clean"     : "c",
    \ 'Ignored'   : 'i',
    \ "Unknown"   : "?"
    \ }

" Map Tab completions for coc.nvim
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Add coc.nvim to status line
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

if has('conceal')
  set conceallevel=0 concealcursor=niv
endif

let g:python_highlight_all = 1
let g:airline#extensions#tabline#enabled = 1

" Some fonts don't play nice with indentLine
let g:indentLine_char = '|'

" Gruvbox high contrast
let g:gruvbox_contrast_dark = 'hard'

" Anyfold configuration
autocmd Filetype * AnyFoldActivate
" }}}

" Behaviour Settings {{{
try
  " Allow persistent undo 
  set undodir=/tmp/$USER/vim_undo
  set undofile
catch
endtry

" Show substitutions as they are being typed
set inccommand=nosplit

" Jump to last location when file is opened
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" }}}

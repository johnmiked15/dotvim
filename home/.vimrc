"-------------------------------------------------------------------------------
" Initialize pathogen
"-------------------------------------------------------------------------------
" Load pathogen.
runtime submodules/pathogen/autoload/pathogen.vim
filetype off

let g:pathogen_disabled = ['tagbar', 'vim-colors-solarized']

execute pathogen#infect()
execute pathogen#helptags()

" Enable plugin support based on filetypes.
filetype on
filetype plugin on
filetype indent on

"-------------------------------------------------------------------------------
" Text formatting
"-------------------------------------------------------------------------------
set encoding=utf-8

set autoindent                       " always set autoindenting on
set expandtab                        " insert spaces when the tab key is pressed
set shiftround                       " use multiple of shiftwidth when indenting
                                     " with '<' and '>'
set shiftwidth=4                     " number of spaces to use for autoindenting
set smarttab                         " insert tabs on the start of a line
                                     " according to shiftwidth, not tabstop
set tabstop=4                        " a tab is four spaces
set wrap                             " wrap overlong lines

"-------------------------------------------------------------------------------
" UI settings
"-------------------------------------------------------------------------------


" Molokai settings
"set t_Co=256                         " force 256 colors by default
let g:molokai_original=0
let g:rehash256=1
"colorscheme molokai                  " set colorscheme for 256 color terminals

" Base16 settings
if &t_Co != 8
    set t_Co=16
endif
"let g:solarized_termtrans=1
"let g:solarized_bold=0
"colorscheme solarized

set background=dark
let g:base16_termtrans=1
let g:base16_term_italics=1
colorscheme base16

call toggletheme#maptransparency("<F10>")
call toggletheme#mapbg("<F11>")
call toggletheme#map256("<F12>")

" Airline theme settings
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the status line)

"let g:airline_theme='solarized'
let g:airline_powerline_fonts=1
let g:solarized_base16=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline#extensions#tabline#buffer_nr_format='%s '

highlight link YcmErrorSection ErrorMsg

set backspace=indent,eol,start       " allow backspacing over everything in
                                     " insert mode
set nofoldenable                     " disable code folding by default
set number                           " always show line numbers
set numberwidth=5                    " we are good for up to 99999 lines
"set ruler                            " show the cursor position all the time
set showcmd                          " display incomplete commands
"set cursorline                       " highlight current line
set modeline                         " enable modeline identifiers in files
set cmdheight=2                      " set cmdheight=2 to avoid pesky
                                     " "Press ENTER to continue" after errors

syntax on                            " enable syntax highlighting

" Resize splits when the window is resized.
au VimResized * exe "normal! \<c-w>="

"-------------------------------------------------------------------------------
" Visual cues
"-------------------------------------------------------------------------------

set incsearch                        " show search matches as you type
set listchars=tab:▸\ ,trail:·        " set custom characters for non-printable
                                     " characters
set list                             " always show non-printable characters
set matchtime=3                      " set brace match time
set scrolloff=3                      " maintain more context around the cursor
set linebreak                        " wrap lines at logical word boundaries
set showbreak=↪                      " character to display in front of wrapper
                                     " lines
set breakindent                      " indent wrapped lines
set showmatch                        " enable brace highlighting
set ignorecase                       " ignore case
set smartcase                        " ignore case if search pattern is all
                                     " lowercase, case-sensitive otherwise
set visualbell                       " only show a visual cue when an error
                                     " occurs
set laststatus=2                     " always show the status line
set showtabline=2

"-------------------------------------------------------------------------------
" Behavioural settings
"-------------------------------------------------------------------------------

set autoread                         " automatically reload a file when it has
                                     " been changed
set backup                           " enable backups
set backupdir=$HOME/.vim/backup      " set the backup directory
set undofile                         " enable persistent undo
set undodir=$HOME/.vim/undo          " persistent undo directory
"set clipboard=unnamedplus            " use the system clipboard by default
set dir=$HOME/.vim/swap              " set the swap directory
set hidden                           " be able to put the current buffer to the
                                     " background without writing to disk and
                                     " remember marks and undo-history when a
                                     " background buffer becomes current again
set history=50                       " keep 50 lines of command line history
set nostartofline                    " do not change the X position of the
                                     " cursor when paging up and down
"set mouse=a
set wildignore+=*.o,*.obj,*.dwo

set ttimeoutlen=0                    " don't wait for key codes (<ESC> is instant)
set updatetime=250                   " write swap file after 250ms of inactivity
                                     " instead of 4000

"-------------------------------------------------------------------------------
" Key remappings
"-------------------------------------------------------------------------------

let mapleader=" "                    " set our personal modifier key to space

set pastetoggle=<F9>                 " <F9> temporarily disables formatting when
                                     " pasting text

" Quickly edit and reload the vimrc file.
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Map Y to copy to the end of the line (which is more logical, also according
" to the Vim manual.
map Y y$

vnoremap < <gv
vnoremap > >gv

vmap <tab> >gv
vmap <s-tab> <gv

nnoremap <silent> <C-h> :bprevious<CR>
nnoremap <silent> <C-l> :bnext<CR>

nnoremap <leader>v V`]

nnoremap / /\v
vnoremap / /\v

" Toggle for side bar
fu! UiToggle(command)
  let b = bufnr("%")
  execute a:command
  execute ( bufwinnr(b) . "wincmd w" )
  "execute ":set number!"
endf

" Toggle the file system tree with F2
nnoremap <silent> <F2> :call UiToggle(":NERDTreeToggle")<CR>

" Close the current buffer
map <leader>bd :Bclose<CR>

" Remap K to do nothing instead of searching the man pages.
nnoremap K <nop>

" Remap Q to do nothing instead of entering ex mode.
nnoremap Q <nop>

" Remap <leader>m to execute a make.
nmap <silent> <leader>m :make<CR>

" Remap Ctrl-k and Ctrl-j to jump to the previous and next compiler error
" respectively.
nmap <silent> <C-k> :cp<CR>
nmap <silent> <C-j> :cn<CR>

" Split window into .h and .cpp using F3
map <F3> :AS<CR>
" Switch between .h and .cpp using F4.
map <F4> :A<CR>
" Switch between .h and _inline.h using F5.
map <F5> :AI<CR>

" Easier escape (jk is so rarely typed this shouldn't be an issue)
inoremap jk <ESC>

" Movement
nnoremap j gj
nnoremap k gk

" Configure fzf mappings
map <leader>s :Ag<space>
map <C-p> :Files<CR>
map <leader>l :Buffer<CR>
map <leader>t :GFiles<CR>
map <leader>h :Commands<CR>
map <leader>? :Helptags<CR>
map <leader>gs :GFiles?<CR>
map <leader>gl :Commits<CR>
map <leader>gbl :BCommits<CR>
inoremap <C-x><C-l> <plug>(fzf-complete-line)

" YouCompleteMe mappings
nnoremap <F6> :YcmForceCompileAndDiagnostics<CR>
nnoremap <leader>jd :YcmCompleter GoTo<CR>

" Miscellaneous
map <leader>w <C-w>

"-------------------------------------------------------------------------------
" Configure plugins
"-------------------------------------------------------------------------------

" Configure "A" plugin
" Never open a non-existing file
let g:alternateNoDefaultAlternate = 1

" Configure YouCompleteMe
"let g:ycm_add_preview_to_completeopt = 1
let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_key_list_select_completion = ['<C-j>', '<Tab>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<S-Tab>', '<Up>']

"" Configure (keyword) completion.
set completeopt=longest,menuone

" Configure vim-rtags
let g:rtagsUseLocationList = 0

" Configure vim-gitgutter
let g:gitgutter_sign_column_always = 1

" Configure gitv
let g:Gitv_TruncateCommitSubjects = 1

" Configure vim-polyglot
let g:polyglot_disabled = ['c/c++']

" Configure fzf
let g:fzf_layout = { 'down': '~15%' }
let g:fzf_commits_log_options = '--graph --color=always --all --pretty=tformat:"%C(auto)%h%d %s %C(green)(%ar)%Creset %C(blue)<%an>%Creset"'

au VimEnter * command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
au VimEnter * command! -bang -nargs=* Ag
            \ call fzf#vim#ag(<q-args>,
            \                 <bang>0 ? fzf#vim#with_preview('up:60%')
            \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
            \                 <bang>0)

"-------------------------------------------------------------------------------
" File type specific settings
"-------------------------------------------------------------------------------

" Automatically remove trailing whitespace before write.
function! StripTrailingWhitespace()
    normal mZ
    %s/\s\+$//e
    normal `Z
endfunction

augroup vimrc_autocmd
    autocmd!
    " Syntax highlighting for Go.
    au BufEnter *.go setlocal syntax=go

    " Set tab stop to 2 for CMake files.
    au BufEnter CMakeLists.txt setlocal tabstop=2
    au BufEnter CMakeLists.txt setlocal shiftwidth=2
    au BufEnter *.cmake setlocal tabstop=2
    au BufEnter *.cmake setlocal shiftwidth=2

    au BufEnter *.xml setlocal tabstop=2
    au BufEnter *.xml setlocal shiftwidth=2

    " Set tab stop to 4 for Vimscript files.
    au BufEnter *.vim setlocal tabstop=4
    au BufEnter *.vim setlocal shiftwidth=4

    " Strip trailing white spaces in source code.
    "au BufWritePre *.cpp,*.hpp,*.h,*.c :call StripTrailingWhitespace()
    au BufWritePre .vimrc,*.js,*.php :call StripTrailingWhitespace()

    " Set text width for C++ code to be able to easily format comments.
    au FileType cpp setlocal textwidth=80
    au FileType cpp setlocal formatoptions=crqnj

    " Add support for Doxygen comment leader.
    au FileType h,hpp,cpp,c setlocal comments^=:///

    " Override vim-polyglot changes to git commit formatting
    au FileType gitcommit setlocal formatlistpat=^\\s*[0-9*-]\\+[\\]:.)}\\t ]\\s*
    au FileType gitcommit setlocal formatoptions+=n

    " Set text width for Changelogs, and do not expand tabs.
    au BufEnter Changelog setlocal textwidth=80
    au BufEnter Changelog setlocal expandtab

    " Set text width for reStructured text.
    au BufEnter *.rst setlocal textwidth=80

    " Set text width for Python to 80 to allow for proper docstring and comment formatting.
    au FileType python setlocal textwidth=80
    au FileType python setlocal formatoptions=crqnj

    au BufEnter *.gradle setlocal filetype=groovy

    au BufEnter *.sqli setlocal filetype=sql
augroup END

"-------------------------------------------------------------------------------
" Misc settings
"-------------------------------------------------------------------------------

" Always start editing a file in case a swap file exists.
augroup SimultaneousEdits
    autocmd!
    autocmd SwapExists * :let v:swapchoice = 'e'
augroup End

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" Read in a custom Vim configuration local to the working directory.
if filereadable(".project.vim")
    so .project.vim
endif

" Close vim if the last window is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

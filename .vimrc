if &term =~ '256color'
    " Disable Background Color Erase (BCE) so that color schemes
    " work properly when Vim is used inside tmux and GNU screen.
    " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif

"===============================General Settings===============================
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Enable file type detection.
filetype plugin indent on

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
  syntax enable
endif

" Set to auto read when a file is changed from the outside
set autoread

" Sets a vertical rule at 80 chars
execute "set colorcolumn=".join(range(81,200), ",")

" display incomplete commands
set showcmd

" Underlines the line your cursor is on
set cursorline

" Set utf8 as standard encoding and en_US as standard language
set encoding=utf8

" Highlight trailing white spaces
match ErrorMsg '\s\+$'

" Make search case-insensitive
set ignorecase

" Unless there is a capital letter in the search
set smartcase

" Sets margin between cursor and top/bottom of window to three lines
set scrolloff=3

" Store all swap-files in ~/.vim-tmp
set backupdir=~/.vim-tmp
set directory=~/.vim-tmp

" Shows line number and percentage through document in bottom-right
set ruler

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" Don't redraw while executing macros (better performance)
set lazyredraw

" Disables search highlight
set nohlsearch

" Line-numbers
set number

" Toggle Paste-mode
set pastetoggle=<F8>

" do incremental searching
set incsearch

" Set wild completion
set wildmenu
set wildmode=longest,list,full

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Makes status bar always be 2 lines tall
set laststatus=2

" Sets status line
set statusline=%F%m%r%y%=%c,%l/%L\ %P

" Remember info about open buffers on close
set viminfo^=%

" Set history to 1000
set history=1000

" Shows title of open file in Terminal Title
set title

" Tab = 4 spaces
set tabstop=4

" Autoindent does exactly what you'd expect
set autoindent

" Smartindent makes indenting a little, well, smarter
set smartindent

" Number of spaces to use for each step of (auto)indent
set shiftwidth=4

" In Insert mode: Use the appropriate number of spaces to insert a <Tab>
set expandtab

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

" Wraps the range of lines with the specified arguments
function! TextWrap(arg1, ...) range
    if (a:arg1=="D" || a:arg1=="d") && exists("a:1")
        let wrapTop="{% ".a:1." %}"
        let wrapBottom="{% end".a:1." %}"
    elseif (a:arg1=="T" || a:arg1=="t") && exists("a:1")
        let wrapTop="<".a:1.">"
        let wrapBottom="</"
    else
        let wrapTop=a:arg1
        let wrapBottom=a:0 > 0 ? a:1 : wrapTop
    endif
    let topline=a:firstline
    let bottomline=exists("a:lastline") ? a:lastline+1 : topline+1
    execute "normal ".topline."ggO".wrapTop
    execute "normal ".bottomline."ggo".wrapBottom
endfunction
command! -range -nargs=+ Wrap <line1>,<line2>call TextWrap(<f-args>)

"=============================Autocommand Settings=============================
" removes trailing white spaces... I think
autocmd BufWritePre * :%s/\s\+$//e

" Turns autocompletion on for various filetypes
autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType aspnet set omnifunc=xmlcomplete#CompleteTags
autocmd FileType aspx set omnifunc=xmlcomplete#CompleteTags

" Re-source .vimrc everytime it's modified
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

"=================================  Mappings  =================================
" Leader Mappings =============================================================
"==============================================================================
" Maps leader key to ,
let mapleader = ","

" Toggle relative/absolute line-numbers
function! RelNumberToggle()
    if(&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunc
nmap <silent> <Leader>1 :call LineNumberToggle()<CR>

" Toggle line-numbers
function! LineNumberToggle()
    if(&relativenumber == 1)
        set invrelativenumber
    elseif(&number == 1)
        set invnumber
    else
        set number
    endif
endfunc
nmap <silent> <Leader>2 :call RelNumberToggle()<CR>

" Tab Navigation
" Use vim's builtin <count>gt to jump to specific tabs
" Open new tab
nnoremap <Leader>;n :tabnew<CR>
" Switch to next tab
nnoremap <Leader>;' :tabnext<CR>
" Switch to previous tab
nnoremap <Leader>;; :tabprevious<CR>
" Close Tab
nnoremap <Leader>;c :tabclose<CR>

" Insert blank lines without going into insert mode
nnoremap <Leader>o o<ESC>k
nnoremap <Leader>O O<ESC>j

" Toggle search highlighting
nnoremap <silent> <Leader>h :set hlsearch!<CR>

" Search and replace selected text
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction
function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

"==============================================================================
" Normal Mode Mappings ========================================================
"==============================================================================
" Re-sources .vimrc
nnoremap <silent><F5> <ESC>:source $MYVIMRC<CR>

" Re-set syntax highlighting
nnoremap <silent><F6> <ESC>:syntax sync fromstart<CR>

" Easier Split Window Navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Next two enable faster scrolling with <C-e> and <C-y>
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Jump to start and end of line using homerow keys
nnoremap H ^
nnoremap L $

" Makes 'Enter' insert a <CR> it's like the opposite of J
nnoremap <C-m> i<C-m><Esc>

" Execute Macros with Q
nnoremap Q @q

" Maps ' to ` so that it jumps to line AND column of mark. It's just easier to
" than hitting ` (it also eliminates the need to excape it from tmux)
nnoremap ' `

" Y yanks to end of line, making it consistant with D and C
nnoremap Y y$

" Keep search pattern at the center of the screen
nnoremap <silent> n nzz
nnoremap <silent> N Nzz

" Remap j and k to scroll by visual lines
nnoremap j gj
nnoremap k gk

" Ctrl+o and Ctrl+i move line up/down
nnoremap <silent><C-i> mz:m+<CR>`z
nnoremap <silent><C-o> mz:m-2<CR>`z

"==============================================================================
" Insert Mode Mappings ========================================================
"==============================================================================

" A quicker alternative to pushing <ESC>
inoremap jk <ESC>
inoremap kj <ESC>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Next two set indenting in insert-mode
inoremap << <C-d>
inoremap >> <C-t>

"**********
" All insert-mode mappings with ctrl stay the same even if in Dvorak
"<C-h> means you press ctrl and the key physically marked 'h'
"(Providing you didn't physically rearrange your keys)
"**********

" Go to beginning of line in insert mode
inoremap <C-a> <ESC>I

" Go to end of line in insert mode
inoremap <C-e> <ESC>A

" Start editing on new line above current line
inoremap <C-p> <ESC>O

" Start editing on new line below current line
inoremap <C-u> <ESC>o

" Move current line up one line (switches places with above line)
inoremap <silent><C-k> <ESC>mz:m-2<CR>`zi

" Move current line down one line (switches places with below line)
inoremap <silent><C-j> <ESC>mz:m+<CR>`zi

"==============================================================================
" Command Mode Mappings =======================================================
"==============================================================================
" Escape spaces in command-mode by pressing space twice
cnoremap <Space><Space> \<Space>
"==============================================================================
" Visual Mode Mappings ========================================================
"==============================================================================
" Yank highlighted text and searches it
vmap <C-n> y/<C-R>"<CR>

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Move current visual selection up or down
vnoremap <C-i> <ESC> `<gv:m '>+1<CR>gv
vnoremap <C-o> <ESC> `<gv:m '<-2<CR>gv

"============================== Plugin Settings ===============================
" SuperTab settings ===========================================================
"==============================================================================
" Cycle through menu from top to bottom
let g:SuperTabDefaultCompletionType = "<C-n>"

"==============================================================================
" TagBar settings =============================================================
"==============================================================================
" Toggles TagBar
nnoremap <silent><Leader>t :TagbarOpen fj<CR>
nnoremap <silent><Leader>T :TagbarClose<CR>

"==============================================================================
" Pangloss javascript syntax/indent settings ==================================
"==============================================================================
" html indentation
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

"==============================================================================
" Unite Settings ===========================================================
"==============================================================================
" Window Width
let g:unite_enable_split_vertically = 1
let g:unite_enable_use_short_source_names = 1
let g:unite_winwidth = 50
" Opens Unite
nnoremap <Space><Space> :Unite -start-insert file_rec/async<CR>
" Open unity to grep
nnoremap <Space>/ :Unite -vertical -auto-preview grep:
" Quick buffer switching
nnoremap <Space>b :Unite -quick-match buffer<CR>
" Open list of recently accessed directories
" Selecting one changes working directory
nnoremap <Space>d :Unite -buffer-name=files -default-action=lcd directory_mru<CR>
" Opens unity and searches for word under cursor
nnoremap <Space>. :UniteWithCursorWord file buffer file_rec<CR>

"==============================================================================
" Syntastic Settings =========================================================
"==============================================================================
" Which syntax checkers to use
let g:syntastic_ada_checkers = ['gcc']
let g:syntastic_c_checkers = ['make']
let g:syntastic_cs_checkers = ['mcs']
let g:syntastic_html_checkers = ['tidy']
let g:syntastic_java_checkers = ['javac']
let g:syntastic_javascript_checkers = ['jsl']
let g:syntastic_objc_checkers = ['gcc']
let g:syntastic_php_checkers = ['php']
let g:syntastic_python_checkers = ['pylint', 'python']
let g:syntastic_sh_checkers = ['sh']
let g:syntastic_zsh_checkers = ['zsh']

"==============================================================================
" Seek Settings ===============================================================
"==============================================================================
let g:seek_enable_jumps = 1

"==============================================================================
" Airline Settings ============================================================
"==============================================================================
let g:airline_powerline_fonts=1

"==============================================================================
" Easymotion Settings =========================================================
"==============================================================================
let g:EasyMotion_leader_key = '<Space>'

"==============================================================================
" Activate Pathogen ===========================================================
"==============================================================================
execute pathogen#infect()

"==============================================================================
" Arpeggio Mappings
"==============================================================================
"let g:arpeggio_timeoutlen=60 "default=40
"call arpeggio#load()
" Quicker alternatives to pressing <ESC>
"Arpeggio inoremap jk <Esc>

"==============================================================================
" CSS Colors ==================================================================
let g:cssColorVimDoNotMessMyUpdateTime = 1
"==============================================================================
" Javascript Libraries settings ===============================================
let g:used_javascript_libs = 'jquery,underscore,backbone'
"==============================================================================
" Matchit macro (allows % to match html/xml tags as well) =====================
runtime macros/matchit.vim
"==============================================================================

"============================Host Dependent Settings===========================
let hostname = substitute(system('hostname'), '\n', '', '')
let current_dir = substitute(system('hostname'), '\n', '', '')

if hostname == "gravelpit"
    source ~/.vimrc.gravel
else
    source ~/.vimrc.local
endif

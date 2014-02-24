"=============================Autocommand Settings=============================
" wsgi files are python
autocmd BufNewFile,BufRead *.wsgi set filetype=python

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Turns autocompletion on for various filetypes
augroup omnifuncs
    autocmd!
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    autocmd FileType c set omnifunc=ccomplete#Complete
    autocmd FileType aspnet set omnifunc=ccomplete#Complete
    autocmd Syntax * if &omnifunc == ""
                \ | setl omnifunc=syntaxcomplete#Complete
                \ | endif
augroup END

" Source file-specific vimrcs
if @% != ""
    runtime @% . ".vimrc"
endif

" Re-source .vimrc everytime it's modified
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost *.vimrc source @%
    autocmd BufWritePost *.vimrc.local source @%
augroup END
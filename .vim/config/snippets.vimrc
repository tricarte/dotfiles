function! MySnippets(...)
    let l:query = a:1
    " let l:terms = floaterm#buflist#gather()
    let l:bufnr = floaterm#terminal#get_bufnr('snpconsole')
    if bufnr == -1
        execute ':FloatermNew --height=0.98 --width=0.95 --position=center --name=snpconsole --title=Console snp ' . query
    else
        execute ':FloatermShow ' . bufnr
    endif

    " TODO: Get column size for vert
    " execute ':vert term ++close snp ' . query
    " silent execute ':FloatermShow snpconsole'
    " execute ':FloatermNew --height=0.98 --width=0.95 --position=center --name=snpconsole --title=Console snp ' . query
    " execute ':r !snp ' . query " this does not work (of course)

    " if(! empty(query))
    "     " TODO: Get column size for vert
    "     execute ':vert term ++close s10 ' . query
    "     " execute ':r !snp ' . query " this does not work (of course)
    " else
    "     echohl WarningMsg | echomsg "Snippet Search => " . 'Current line is empty!' | echohl None
    " endif
endfunction

" nnoremap <space>oo :call MySnippets(getline('.'))<CR>
" nnoremap <space>oo :call MySnippets("")<CR>
command! -nargs=? Snp call MySnippets("<args>")
" command! Snp call MySnippets("<args>")
cnoreabbrev snp Snp

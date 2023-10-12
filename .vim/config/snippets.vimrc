function! MySnippets(...)
    let l:query = a:1

    " TODO: Get column size for vert
    execute ':vert term ++close snp ' . query
    " execute ':r !snp ' . query " this does not work (of course)

    " if(! empty(query))
    "     " TODO: Get column size for vert
    "     execute ':vert term ++close s10 ' . query
    "     " execute ':r !snp ' . query " this does not work (of course)
    " else
    "     echohl WarningMsg | echomsg "Snippet Search => " . 'Current line is empty!' | echohl None
    " endif
endfunction

nnoremap <space>oo :call MySnippets(getline('.'))<CR>
command! -nargs=? Snp call MySnippets("<args>")
" command! Snp call MySnippets("<args>")
cnoreabbrev snp Snp

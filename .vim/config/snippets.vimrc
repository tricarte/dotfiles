function! MySnippets(...)
    let l:query = a:1
    if(! empty(query))
        " TODO: Get column size for vert
        execute ':vert term snp ' . query
    else
        echohl WarningMsg | echomsg "Snippet Search => " . 'Current line is empty!' | echohl None
    endif
endfunction

nnoremap <space>oo :call MySnippets(getline('.'))<CR>
command! -nargs=1 Snp call MySnippets("<args>")
cnoreabbrev snp Snp

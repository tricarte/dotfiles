" TODO: :Search php:alternative syntax
" If it's called without any arguments use the ones
" supplied with the :Search command.
function! MySnippets(...)
    let l:query = a:1
    if(! empty(query))
        execute ':term snippets.pl ' . query
    else
        echohl WarningMsg | echomsg "Snippet Search => " . 'Current line is empty!' | echohl None
    endif
endfunction

nnoremap <space>oo :call MySnippets(getline('.'))<CR>
command! -nargs=1 Search call MySnippets("<args>")

vim9script
g:vimcomplete_tab_enable = 1

# var dictproperties = {
#     python: { sortedDict: false },
#     text: { sortedDict: true },
#     markdown: { sortedDict: true },
# }
# var vcoptions = {
#     dictionary: {
#         enable: true,
#         priority: 11,
#         filetypes: ['python', 'text', 'markdown'],
#         properties: dictproperties,
#     },
# }
# autocmd VimEnter * g:VimCompleteOptionsSet(vcoptions)
# autocmd FileType text set dictionary+=/usr/share/dict/american-english
# autocmd FileType python set dictionary=$HOME/.vim/data/pythondict

var options = {
    completor: {
        shuffleEqualPriority: false,
        postfixHighlight: true,
        kindDisplayType: 'icon',
        customInfoWindow: true,
        matchCase: true,
        noNewlineInCompletion: true,
        noNewlineInCompletionEver: true,
        postfixClobber: true, # foo<cursor>bar -> foosome (remove bar when complete)
        # postfixHighlight: true # Highlight the postfix and use <C-l> to delete it
        recency: false, # Don't display recently selected items at the top.
        # triggerWordLen: 3 # Breaks vimcomplete
    },
    buffer: {
        enable: true,
        priority: 9,
        urlComplete: true,
        envComplete: true,
        completionMatcher: 'fuzzy',
        maxCount: 20,
        otherBuffersCount: 0, # Only search in this buffer
        filetypes: ['text', 'markdown']
    },
    ngram: {
        enable: true,
        priority: 10,
        bigram: true,
        filetypes: ['text', 'help', 'markdown'],
        filetypesComments: ['php', 'javascript', 'typescript', 'perl', 'vim', 'sh', 'lua'],
    },
    abbrev: { enable: true, priority: 10 },
    # dictionary: {
    #     enable: true,
    #     priority: 9,
    #     filetypes: ['python', 'text'],
    #     properties: {
    #         python: { sortedDict: false },
    #         text: { sortedDict: true }
    #     }
    # },
    lsp: {
        enable: true,
        priority: 11,
        maxCount: 20,
        keywordOnly: false, # Default false
        # completionMatcher: 'fuzzy', # This may not be supported by phpactor
    },
    vsnip: { enable: true, priority: 12 },
    omnifunc: { enable: false, priority: 8, filetypes: ['javascript', 'php', 'css', 'perl', 'lua'] },
    # vimscript: { enable: true, priority: 11 },
}
autocmd VimEnter * g:VimCompleteOptionsSet(options)

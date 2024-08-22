" let lspOpts = #{autoHighlightDiags: v:true}
" autocmd User LspSetup call LspOptionsSet(lspOpts)

" " Defaults
" call LspOptionsSet(#{
"         \   aleSupport: v:false,
"         \   autoComplete: v:true,
"         \   autoHighlight: v:false,
"         \   autoHighlightDiags: v:true,
"         \   autoHighlightDiags: v:true,
"         \   autoPopulateDiags: v:false,
"         \   completionMatcher: 'case',
"         \   completionMatcherValue: 1,
"         \   diagSignErrorText: 'E>',
"         \   diagSignHintText: 'H>',
"         \   diagSignInfoText: 'I>',
"         \   diagSignWarningText: 'W>',
"         \   echoSignature: v:false,
"         \   hideDisabledCodeActions: v:false,
"         \   highlightDiagInline: v:true,
"         \   hoverInPreview: v:false,
"         \   ignoreMissingServer: v:false,
"         \   keepFocusInDiags: v:true,
"         \   keepFocusInReferences: v:true,
"         \   completionTextEdit: v:true,
"         \   diagVirtualTextAlign: 'above',
"         \   diagVirtualTextWrap: 'default',
"         \   noNewlineInCompletion: v:false,
"         \   omniComplete: v:null,
"         \   outlineOnRight: v:false,
"         \   outlineWinSize: 20,
"         \   semanticHighlight: v:true,
"         \   showDiagInBalloon: v:true,
"         \   showDiagInPopup: v:true,
"         \   showDiagOnStatusLine: v:false,
"         \   showDiagWithSign: v:true,
"         \   showDiagWithVirtualText: v:false,
"         \   showInlayHints: v:false,
"         \   showSignature: v:true,
"         \   snippetSupport: v:false,
"         \   ultisnipsSupport: v:false,
"         \   useBufferCompletion: v:false,
"         \   usePopupInCodeAction: v:false,
"         \   useQuickfixForLocations: v:false,
"         \   vsnipSupport: v:false,
"         \   bufferCompletionTimeout: 100,
"         \   customCompletionKinds: v:false,
"         \   completionKinds: {},
"         \   filterCompletionDuplicates: v:false,
" 	\ })

let lspOpts = #{
        \   aleSupport: v:false,
        \   autoComplete: v:true,
        \   autoHighlight: v:false,
        \   autoHighlightDiags: v:false,
        \   autoPopulateDiags: v:false,
        \   completionMatcher: 'fuzzy',
        \   completionMatcherValue: 1,
        \   diagSignErrorText: 'E>',
        \   diagSignHintText: 'H>',
        \   diagSignInfoText: 'I>',
        \   diagSignWarningText: 'W>',
        \   echoSignature: v:true,
        \   hideDisabledCodeActions: v:false,
        \   highlightDiagInline: v:true,
        \   hoverInPreview: v:false,
        \   ignoreMissingServer: v:false,
        \   keepFocusInDiags: v:true,
        \   keepFocusInReferences: v:true,
        \   completionTextEdit: v:true,
        \   diagVirtualTextAlign: 'above',
        \   diagVirtualTextWrap: 'default',
        \   noNewlineInCompletion: v:false,
        \   omniComplete: v:false,
        \   outlineOnRight: v:true,
        \   outlineWinSize: 20,
        \   semanticHighlight: v:true,
        \   showDiagInBalloon: v:true,
        \   showDiagInPopup: v:true,
        \   showDiagOnStatusLine: v:false,
        \   showDiagWithSign: v:true,
        \   showDiagWithVirtualText: v:false,
        \   showInlayHints: v:true,
        \   showSignature: v:true,
        \   snippetSupport: v:false,
        \   ultisnipsSupport: v:false,
        \   useBufferCompletion: v:false,
        \   usePopupInCodeAction: v:false,
        \   useQuickfixForLocations: v:false,
        \   vsnipSupport: v:true,
        \   bufferCompletionTimeout: 100,
        \   customCompletionKinds: v:false,
        \   completionKinds: {},
        \   filterCompletionDuplicates: v:false,
	\ }
autocmd User LspSetup call LspOptionsSet(lspOpts)

" Working phpactor lsp config
" let lspServers = [#{
" 	\	  name: 'phpactor',
" 	\	  filetype: ['php'],
" 	\	  path: '/usr/local/bin/phpactor',
" 	\	  args: ['language-server']
" 	\ }]

            " \ #{
            " \	  name: 'v-analyzer',
            " \	  filetype: ['vlang'],
            " \	  path: $HOME . '/.config/v-analyzer/bin/v-analyzer',
            " \	  args: []
            " \ },
let lspServers = [
            \ #{
            \	  name: 'intelephense',
            \	  filetype: ['php'],
            \	  path: $HOME . '/.bun/bin/bun',
            \	  args: [ $HOME . '/.npm-global/bin/intelephense', '--stdio']
            \ },
            \ #{name: 'gopls',
            \   filetype: 'go',
            \   path: $HOME . '/go/bin/gopls',
            \   args: ['serve']
            \ },
            \ #{
            \   name: 'luals',
            \   filetype: 'lua',
            \   path: $HOME . '/bin/lua-language-server-3.10.1-linux-x64/bin/lua-language-server',
            \   args: [],
            \   workspaceConfig: #{
            \     Lua: #{
            \       diagnostics: #{
            \         enable: v:false,
            \       },
            \       format: #{
            \         enable: v:true
            \       },
            \       runtime: #{
            \         version: 'LuaJIT'
            \       }
            \     }
            \   },
            \ }]

" Example extra config for luals. Put this into luals config above.
" For settings: https://luals.github.io/wiki/settings/
    " \   workspaceConfig: #{
    " \     Lua: #{
    " \       hint: #{
    " \         enable: v:true,
    " \       }
    " \     }
    " \   }

" 	Other modules: curl openssl simplexml xml xmlwriter
" let lspServers = [#{
" 	\	  name: 'phpactor',
" 	\	  filetype: ['php'],
" 	\	  path: '/usr/bin/php',
" 	\	  args: [
"     \       '-n',
"     \        '-dextension=phar',
"     \        '-dextension=ctype',
" 	\        '-dextension=mbstring',
" 	\        '-dextension=tokenizer',
" 	\        '-dextension=dom',
" 	\        '-dextension=curl',
" 	\        '-dextension=openssl',
" 	\        '-dextension=simplexml',
" 	\        '-dextension=xml',
" 	\        '-dextension=xmlwriter',
" 	\        '/usr/local/bin/phpactor.phar',
" 	\        'language-server'
" 	\      ]
" 	\ }]
autocmd User LspSetup call LspAddServer(lspServers)
" call LspAddServer([#{name: 'phpactor',
"                  \   filetype: ['php'],
"                  \   path: '/usr/local/bin/phpactor',
"                  \   args: ['language-server']
"                  \ }])

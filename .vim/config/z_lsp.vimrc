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

" lua-language-server has this startup option: -configpath=sumnekoLuaConfig.lua

function! HandleNotifications(lspserver, reply)
    echo "LSP Server started!"
endfunction

" intelephense configuration
" https://github.com/bmewburn/intelephense-docs/blob/master/installation.md
let lspServers = [
        \  #{
        \     name: 'v-analyzer',
        \     path: $HOME.'/.config/v-analyzer/bin/v-analyzer',
        \     args: [ '--stdio' ],
        \     filetype: ['vlang'],
        \     runUnlessSearch: ['examples/', 'vlib/'],
        \     runIfSearch: ['.root', 'v.mod'],
        \     rootSearch: ['.root', 'v.mod'],
        \     customNotificationHandlers: { "experimental/serverStatus": function('HandleNotifications'), },
        \ },
        \  #{
        \     name: 'ccls',
        \     path: '/usr/bin/ccls',
        \     filetype: ['c', 'cpp', 'objc', 'objcpp', 'cc'],
        \     root_uri: {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
        \     initialization_options: {'cache': {'directory': expand('~/.cache/ccls') }},
        \ },
        \ #{
        \	  name: 'intelephense',
        \	  filetype: ['php'],
        \	  path: $HOME.'/.npm-global/bin/intelephense',
        \	  args: [ '--stdio' ],
        \     runIfSearch: ['composer.json'],
        \     rootSearch: ['composer.json'],
        \     initializationOptions: #{
        \        format: #{
        \            enable: v:true,
        \            braces: 'psr12'
        \        }
        \     }
        \ },
        \ #{
        \   name: 'gopls',
        \   filetype: 'go',
        \   path: $HOME . '/go/bin/gopls',
        \   args: ['serve']
        \ },
        \ #{
        \   name: 'luals',
        \   filetype: 'lua',
        \   path: $HOME.'/bin/lua-language-server-3.13.5-linux-x64/bin/lua-language-server',
        \   runIfSearch: ['lua_modules/', '.root'],
        \   rootSearch: ['lua_modules/', '.root'],
        \   customNotificationHandlers: { "$/hello": function('HandleNotifications'), },
        \   workspaceConfig: #{
        \     Lua: #{
        \       diagnostics: #{
        \         enable: v:false,
        \       },
        \       format: #{
        \         enable: v:true,
        \       },
        \       runtime: #{
        \         version: 'LuaJIT',
        \         fileEncoding: 'utf8',
        \         pathStrict: v:true,
        \       },
        \       semantic: #{
        \         enable: v:false,
        \       }
        \     }
        \   },
        \ }]

            " \ #{
            " \   name: 'yaml-language-server',
            " \   path: $HOME . '/.npm-global/bin/yaml-language-server',
            " \   filetype: 'yaml',
            " \   args: ['--stdio'],
            " \   workspaceConfig: #{
            " \     yaml: #{
            " \       validate: v:true,
            " \       hover: v:true,
            " \       completion: v:true,
            " \       customTags: [],
            " \       schemas: #{},
            " \       schemaStore: #{ enable: v:true },
            " \       format: #{ enable: v:true },
            " \     },
            " \   },
            " \ },

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


nmap <silent> gd :LspGotoDefinition<CR>

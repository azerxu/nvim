-- map key setting
-- <CR>  : Insert new indented line after return if cursor in blank brackets or quotes.
-- <BS>  : Delete brackets in pair
-- <M-p> : Toggle Autopairs (g:AutoPairsShortcutToggle)
-- <M-e> : Fast Wrap (g:AutoPairsShortcutFastWrap)
-- <M-0> : Jump to next closed pair (g:AutoPairsShortcutJump)
-- <M-9> : BackInsert (g:AutoPairsShortcutBackInsert)

-- When the filetype is FILETYPE then make AutoPairs only match for parenthesis
vim.cmd([[
    autocmd FileType php let b:AutoPairs = AutoPairsDefine({'<?' : '?>', '<?php': '?>'})
    autocmd FileType html let b:AutoPairs = AutoPairsDefine({'<!--' : '-->'}, ['{'])
    autocmd FileType ruby let b:AutoPairs = AutoPairsDefine({'begin': 'end//n]'})
]])

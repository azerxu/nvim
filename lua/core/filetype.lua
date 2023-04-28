vim.cmd("autocmd FileType go nmap <Leader><Leader>l GoLint")
vim.cmd("autocmd FileType go nmap <Leader>gc :lua require('go.comment').gen()")

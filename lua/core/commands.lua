local cmd = vim.cmd

-- detect filetypes and load corresponding plugins
cmd("filetype plugin on")

-- detect filetypes and load corresponding indent files
cmd("filetype indent on")

-- autojump to the last edited position when a file is reopened
cmd([[autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif]])

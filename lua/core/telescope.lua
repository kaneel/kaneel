local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fgc", builtin.git_commits, {})
vim.keymap.set("n", "<leader>fgb", builtin.git_branches, {})
vim.keymap.set("n", "<leader>fgs", builtin.git_stash, {})

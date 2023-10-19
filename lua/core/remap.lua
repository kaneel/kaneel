--- ,ft will fold html tag
vim.keymap.set("n", "<leader>ft", "Vatzf")

vim.keymap.set("i", "<c-c>", "<esc>")
vim.keymap.set("n", "<leader>ev", ":vsp $MYVIMRC<CR>")
vim.keymap.set("n", "<leader>ez", ":vsp ~/.zshrc<CR>")
vim.keymap.set("n", "<leader>sv", ":source $MYVIMRC<CR>")

--- OS X Copy
vim.keymap.set("v", "<leader>cp", ':!pbcopy<CR>u :echo "copied"<CR>')
--- ,s to save
vim.keymap.set("n", "<leader>s", ":w<CR>")
-- ,j or ,k to move line up or down
vim.keymap.set("n", "<leader>j", ":m +1<CR>")
vim.keymap.set("n", "<leader>k", ":m -2<CR>")
-- , to move next or prev
vim.keymap.set("n", "<leader>z", ":bp<CR>")
vim.keymap.set("n", "<leader>x", ":bn<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "-", ":Explore<CR>")

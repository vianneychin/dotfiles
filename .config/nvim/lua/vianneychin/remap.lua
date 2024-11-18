vim.g.mapleader = " "

-- Go to next/previous match, center screen, and unfold code sections
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Remap Ctrl-c to Esc so that we can utilize Esc's InsertLeave event
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Disable keys
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "gp", vim.diagnostic.open_float)
vim.keymap.set("n", "gP", vim.lsp.buf.hover)

vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Open netrw." })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move cursor half a page down and center screen" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move cursor half a page up and center screen" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true, desc = "Switch to left pane." })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true, desc = "Switch to bottom pane." })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true, desc = "Switch to top pane." })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true, desc = "Switch to right pane." })
vim.keymap.set("n", "<C-Up>", "<Cmd>resize +2<CR>", { silent = true, desc = "Increase pane height." })
vim.keymap.set("n", "<C-Down>", "<Cmd>resize -2<CR>", { silent = true, desc = "Decrease pane height." })
vim.keymap.set("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { silent = true, desc = "Decrease pane width." })
vim.keymap.set("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { silent = true, desc = "Increase pane width." })
vim.keymap.set('n', '<leader>\\', '<C-w>v', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>|', '<C-w>s', { desc = 'Split window horizontally' })
vim.keymap.set('n', '<leader>b', ':ls<CR>:b ', { noremap = true, silent = false, desc = 'List Buffers and switch.' });
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d", { silent = false, desc = 'Delete without overwriting register.' })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { silent = false, desc = "Yank to system clipboard." })
vim.keymap.set("n", "<leader>Y", [["+Y]], { silent = false, desc = "Yank to system clipboard." })
vim.keymap.set("x", "<leader>p", [["_dP]], { silent = false, desc = "Paste over visually selected text without overwriting register." })


vim.api.nvim_create_user_command("L", "Lazy", {})
vim.api.nvim_create_user_command("M", "Mason", {})

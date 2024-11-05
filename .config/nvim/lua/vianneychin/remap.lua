vim.g.mapleader = " "

-- Opens netrw file tree
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Go half a page up and down and center screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Go to next/previous match, center screen, and unfold code sections
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste over visually selected text without overwriting register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete without overwriting register
vim.keymap.set({"n", "v"}, "<leader>d", "\"_d")

-- Remap Ctrl-c to Esc so that we can utilize Esc's InsertLeave event
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Disable keys
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Reloads nivm configuration
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

vim.g.mapleader = " "

-- Go to next/previous match, center screen, and unfold code sections
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Remap Ctrl-c to Esc so that we can utilize Esc's InsertLeave event
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Disable keys
vim.keymap.set("n", "Q", "<nop>")

-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "gp", vim.diagnostic.open_float)
vim.keymap.set("n", "gP", vim.lsp.buf.hover)

-- Interprets :W as :w because y'know
vim.cmd("cnoreabbrev W w")

-- vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Open netrw." })
vim.keymap.set("n", "<C-i>", "<C-i>zz", { desc = "Move cursor back and center screen" })
vim.keymap.set("n", "<C-o>", "<C-o>zz", { desc = "Move cursor forward and center screen" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move cursor half a page down and center screen" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move cursor half a page up and center screen" })
vim.keymap.set("n", "*", "*zz", { desc = "Go to next matching occurrence and center screen" })
vim.keymap.set("n", "#", "#zz", { desc = "Go to previous matching occurrence and center screen" })
vim.keymap.set("n", "'1", "'1zz", { desc = "Jump to mark and center screen" })
vim.keymap.set("n", "'2", "'2zz", { desc = "Jump to mark and center screen" })
vim.keymap.set("n", "'3", "'3zz", { desc = "Jump to mark and center screen" })
vim.keymap.set("n", "'4", "'4zz", { desc = "Jump to mark and center screen" })
vim.keymap.set("n", "'5", "'5zz", { desc = "Jump to mark and center screen" })
vim.keymap.set("n", "gd", "gdzz", { desc = "Go to definition and center screen" })
vim.keymap.set("n", "gf", "gfzz", { desc = "Go to file and center screen" })

-- Gonna just use the remaps for treewalker.nvim
-- vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true, desc = "Switch to left pane." })
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true, desc = "Switch to bottom pane." })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true, desc = "Switch to top pane." })
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true, desc = "Switch to right pane." })
vim.keymap.set("n", "<C-Up>", "<Cmd>resize +5<CR>", { silent = true, desc = "Increase pane height." })
vim.keymap.set("n", "<C-Down>", "<Cmd>resize -5<CR>", { silent = true, desc = "Decrease pane height." })
vim.keymap.set("n", "<C-Left>", "<Cmd>vertical resize -5<CR>", { silent = true, desc = "Decrease pane width." })
vim.keymap.set("n", "<C-Right>", "<Cmd>vertical resize +5<CR>", { silent = true, desc = "Increase pane width." })
vim.keymap.set("n", "<leader>\\", "<C-w>v", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>|", "<C-w>s", { desc = "Split window horizontally" })
-- vim.keymap.set("n", "<leader>b", ":ls<CR>:b ", { noremap = true, silent = false, desc = "List Buffers and switch." })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { silent = false, desc = "Yank to system clipboard." })
vim.keymap.set(
	"x",
	"<leader>p",
	[["_dP]],
	{ silent = false, desc = "Paste over visually selected text without overwriting register." }
)

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-c>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "[q", "<Cmd>cprev<CR>", { desc = "Next item in the quickfix list." })
vim.keymap.set("n", "]q", "<Cmd>cnext<CR>", { desc = "Previous item in the quickfix list." })

vim.keymap.set("n", "[d", function()
	vim.diagnostic.goto_next({ float = false })
end, { desc = "Next diagnostic without hover" })

vim.keymap.set("n", "]d", function()
	vim.diagnostic.goto_prev({ float = false })
end, { desc = "Previous diagnostic without hover" })

vim.api.nvim_set_keymap(
	"n",
	"<leader>gn",
	":execute 'Gwrite' | execute 'normal! jdd'<CR>",
	{ noremap = true, silent = true, desc = "Stage current file and view next diff" }
)

-- vim.keymap.set("n", "<leader>=", "<Cmd>!node %<CR>", { desc = "Run the current nodejs file" })

vim.api.nvim_create_user_command("L", "Lazy", {})
vim.api.nvim_create_user_command("M", "Mason", {})

vim.keymap.set("v", "<leader>/", function()
	local count = vim.v.count
	vim.cmd.norm((count > 0 and count or "") .. "gcc")
end)

vim.keymap.set("n", "<leader>/", function()
	local count = vim.v.count
	vim.cmd.norm((count > 0 and count or "") .. "gcc")
end)

vim.keymap.set("o", "<leader>/", function()
	local count = vim.v.count
	vim.cmd.norm((count > 0 and count or "") .. "gcc")
end)

vim.keymap.set("x", "<leader>/", function()
	local count = vim.v.count
	vim.cmd.norm((count > 0 and count or "") .. "gcc")
end)
vim.keymap.set("n", "<leader>Q", function()
	vim.cmd("qa!")
end, { silent = true, desc = "Force quit" })

-- Swap Tab and Escape
-- vim.keymap.set({ "n", "v" }, "<Tab>", "<Esc>", { noremap = true })
-- vim.keymap.set({ "n", "v" }, "<Esc>", "<Tab>", { noremap = true })
-- vim.keymap.set({ "i", "c" }, "<Tab>", "<Esc>", { noremap = true })
-- vim.keymap.set({ "i", "c" }, "<Esc>", "<Tab>", { noremap = true })

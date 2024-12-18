return {
	"aaronik/treewalker.nvim",
	opts = {
		highlight = true,
	},
	config = function()
		vim.api.nvim_set_keymap("n", "<C-j>", ":Treewalker Down<CR>zz", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<C-k>", ":Treewalker Up<CR>zz", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<C-h>", ":Treewalker Left<CR>zz", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<C-l>", ":Treewalker Right<CR>zz", { noremap = true, silent = true })
	end,
}

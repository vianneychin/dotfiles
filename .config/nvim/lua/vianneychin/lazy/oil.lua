return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
	config = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
		vim.keymap.set("n", "<leader>e", function()
			if pcall(require, "oil") then
				require("oil").open()
			else
				vim.cmd.Ex()
			end
		end, { desc = "Open Oil (fallback to netrw)" })
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		require("oil").setup({
			default_file_explorer = false,
			view_options = {
				show_hidden = true,
			},
			keymaps = {
				["<C-c>"] = {},
			},
		})
	end,
}

return {
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {},
	-- 	config = function()
	-- 		vim.cmd.colorscheme("tokyonight-night")
	-- 	end,
	-- },
	{
		"catppuccin/nvim",
		priority = 1000,
		lazy = false,
		config = function()
			require("catppuccin").setup({
				term_colors = true,
				color_overrides = {
					mocha = {
						base = "#14141c",
					},
				},
			})
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
}

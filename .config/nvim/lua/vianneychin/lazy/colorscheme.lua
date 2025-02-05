return {
	{
		"catppuccin/nvim",
		priority = 1000,
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

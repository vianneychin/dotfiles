return {
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
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		opts = {
			overrides = function(colors)
				local theme = colors.theme
				return {
					Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
					PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
					PmenuSbar = { bg = theme.ui.bg_m1 },
					PmenuThumb = { bg = theme.ui.bg_p2 },
					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none" },
					FloatTitle = { bg = "none" },
					NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
					LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
					MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
				}
			end,
			colors = {
				palette = {
					sumiInk0 = "#1F1F28",
					peachRed = "#957FB8", -- change red to baby violet
					waveRed = "#d98bd6", -- change red to baby pink
				},
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},
		},
	},
}

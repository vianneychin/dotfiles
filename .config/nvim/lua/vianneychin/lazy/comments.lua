return {
	"folke/ts-comments.nvim",
	opts = {
		lang = {
			phpdoc = { "// %s" },
			blade = { "{{-- %s --}}" },
		},
	},
	event = "VeryLazy",
	-- enabled = vim.fn.has("nvim-0.10.0") == 1,
}

return {
	"folke/trouble.nvim",
	opts = {
		modes = {
			cascade = {
				mode = "diagnostics", -- inherit from diagnostics mode
				filter = function(items)
					local severity = vim.diagnostic.severity.HINT
					for _, item in ipairs(items) do
						severity = math.min(severity, item.severity)
					end
					return vim.tbl_filter(function(item)
						return item.severity == severity
					end, items)
				end,
			},
		},
	},
	cmd = "Trouble",
	lazy = "VeryLazy",
	keys = {
		{
			"<leader>tt",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>tt",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>cl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
			"<leader>xL",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List (Trouble)",
		},
		{
			"<leader>xQ",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
		{
			"[t",
			function()
				require("trouble").previous({ skip_groups = true, jump = true })
			end,
			desc = "Previous trouble item",
		},
		{
			"]t",
			function()
				require("trouble").next({ skip_groups = true, jump = true })
			end,
			desc = "Next trouble item",
		},
	},
}

-- For additional defaults, i.e., setting a hotkey to toggle formatting
-- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#lazy-loading-with-lazynvim

return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		-- This will provide type hinting with LuaLS
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			-- Define your formatters
			formatters_by_ft = {
				php = { "php-cs-fixer", "pint" },
				lua = { "stylua", "trim_whitespace" },
				python = { "isort", "black", "trim_whitespace" },
				javascript = { "prettierd", "prettier", "trim_whitespace", stop_after_first = true },
				typescript = { "prettierd", "prettier", "trim_whitespace", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", "trim_whitespace", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", "trim_whitespace", stop_after_first = true },
				scss = { "prettierd", "prettier", "trim_whitespace", stop_after_first = true },
				vue = { "prettierd", "prettier", "trim_whitespace" },
				blade = { "blade-formatter", "trim_whitespace" },
				["*"] = { "trim_whitespace" },
			},

			default_format_opts = {
				lsp_format = "fallback",
			},

			format_on_save = {
				timeout_ms = 250,
			},

			formatters = {
				shfmt = {
					prepend_args = { "-i", "2" },
				},
			},
		},
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
}

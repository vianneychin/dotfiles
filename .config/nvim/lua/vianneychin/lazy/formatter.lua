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
				json = { "prettierd", "prettier", "trim_whitespace", stop_after_first = true },
				php = { "pint" }, -- Use LSP formatting for PHP (Intelephense)
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

			format_on_save = {
				timeout_ms = 250,
			},

			formatters = {
				pint = {
					prepend_args = {
						"--config=" .. vim.fn.stdpath("config") .. "/pint.json",
					},
				},
			},
		},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
}

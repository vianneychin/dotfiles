-- For additional defaults, i.e., setting a hotkey to toggle formatting
-- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#lazy-loading-with-lazynvim

return {
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
			lua = { "stylua" },
			python = { "isort", "black" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true }, -- For .jsx
			typescriptreact = { "prettierd", "prettier", stop_after_first = true }, -- For .tsx
			scss = { "prettierd", "prettier", stop_after_first = true },
			vue = { "prettierd", "prettier" },
			blade = { "blade-formatter" },
			-- php = { "pint" },
		},

		default_format_opts = {
			lsp_format = "fallback",
		},

		format_on_save = { timeout_ms = 500 },

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
}

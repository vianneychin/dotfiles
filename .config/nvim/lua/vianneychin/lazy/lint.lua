return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			php = { "phpstan" },
			vue = { "eslint_d" },
			-- javascript = { "eslint_d" },
			-- typescript = { "eslint_d" },
			-- javascriptreact = { "eslint_d" },
			-- typescriptreact = { "eslint_d" },
		}
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				local lint = require("lint")
				local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
				vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
					group = lint_augroup,
					callback = function()
						lint.try_lint()
					end,
				})
			end,
		})
	end,
}

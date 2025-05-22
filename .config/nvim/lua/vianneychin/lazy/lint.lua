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
				local linter = require("lint")
				local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
				vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
					group = lint_augroup,
					callback = function()
						linter.try_lint()
						-- linter.try_lint("cspell")
						-- linter.linters.cspell = require("lint.util").wrap(lint.linters.cspell, function(diagnostic)
						-- 	diagnostic.severity = vim.diagnostic.severity.HINT
						-- 	return diagnostic
						-- end)
					end,
				})
			end,
		})
	end,
}

vim.api.nvim_create_augroup("HighlightYank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	group = "HighlightYank",
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 200,
		})
	end,
})

-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	callback = function()
-- 		if require("nvim-treesitter.parsers").has_parser() then
-- 			vim.opt.foldmethod = "expr"
-- 			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- 		else
-- 			vim.opt.foldmethod = "syntax"
-- 		end
-- 	end,
-- })

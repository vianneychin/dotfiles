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

-- Default to formatter disabled
vim.g.disable_autoformat = true -- Global variable to disable formatting by default
vim.b.disable_autoformat = true -- Buffer-local variable to disable formatting by default

require("conform").setup({
	format_on_save = function(bufnr)
		-- Disable with a global or buffer-local variable
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		return { timeout_ms = 500, lsp_format = "fallback" }
	end,
})

vim.api.nvim_create_user_command("DisableFormatter", function(args)
	if args.bang then
		vim.b.disable_autoformat = true
	else
		vim.g.disable_autoformat = true
	end
end, {
	desc = "Disable autoformat-on-save",
	bang = true,
})
vim.api.nvim_create_user_command("EnableFormatter", function()
	vim.b.disable_autoformat = false
	vim.g.disable_autoformat = false
end, {
	desc = "Re-enable autoformat-on-save",
})

vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("restore_session", { clear = true }),
	callback = function()
		if vim.fn.getcwd() ~= vim.env.HOME then
			require("persistence").load()
		end
	end,
	nested = true,
})

vim.api.nvim_create_autocmd("InsertEnter", { command = [[set norelativenumber]] })

vim.api.nvim_create_autocmd("InsertLeave", { command = [[set relativenumber]] })

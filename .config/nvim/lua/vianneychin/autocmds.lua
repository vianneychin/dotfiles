vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
	desc = "go to last loc when opening a buffer",
})

vim.api.nvim_create_augroup("DisableAutoFormatForSCSS", { clear = true })
-- Create an autocmd for SCSS files
vim.api.nvim_create_autocmd("FileType", {
	group = "DisableAutoFormatForSCSS",
	pattern = "scss",
	callback = function()
		-- Disable automatic formatting
		vim.opt_local.formatoptions:remove("t")
	end,
})

------------------------------------------------
--
-- Formatter
--
------------------------------------------------
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
------------------------------------------------
--
-- END Formatter
--
------------------------------------------------

------------------------------------------------

--
-- Quickfix
--
------------------------------------------------
local custom_group = vim.api.nvim_create_augroup("custom", { clear = true })
-- Remove items from quickfix list.
-- `dd` to delete in Normal
-- `d` to delete Visual selection
local function delete_qf_items()
	local mode = vim.api.nvim_get_mode()["mode"]
	local start_idx
	local count
	if mode == "n" then
		-- Normal mode
		start_idx = vim.fn.line(".")
		count = vim.v.count > 0 and vim.v.count or 1
	else
		-- Visual mode
		local v_start_idx = vim.fn.line("v")
		local v_end_idx = vim.fn.line(".")

		start_idx = math.min(v_start_idx, v_end_idx)
		count = math.abs(v_end_idx - v_start_idx) + 1

		-- Go back to normal
		vim.api.nvim_feedkeys(
			vim.api.nvim_replace_termcodes(
				"<esc>", -- what to escape
				true, -- Vim leftovers
				false, -- Also replace `<lt>`?
				true -- Replace keycodes (like `<esc>`)?
			),
			"x", -- Mode flag
			false -- Should be false, since we already `nvim_replace_termcodes()`
		)
	end

	local qflist = vim.fn.getqflist()

	for _ = 1, count, 1 do
		table.remove(qflist, start_idx)
	end

	vim.fn.setqflist(qflist, "r")
	vim.fn.cursor(start_idx, 1)
end

-- Use vim keybindings to delete items in quick fix
vim.api.nvim_create_autocmd("FileType", {
	group = custom_group,
	pattern = "qf",
	callback = function()
		-- Do not show quickfix in buffer lists.
		vim.api.nvim_buf_set_option(0, "buflisted", false)

		-- Escape closes quickfix window.
		vim.keymap.set("n", "<ESC>", "<CMD>cclose<CR>", { buffer = true, remap = false, silent = true })

		-- `dd` deletes an item from the list.
		vim.keymap.set("n", "dd", delete_qf_items, { buffer = true })
		vim.keymap.set("x", "d", delete_qf_items, { buffer = true })
	end,
	desc = "Quickfix tweaks",
})

------------------------------------------------
--
-- END Quickfix
--
------------------------------------------------

-- Add '$' to iskeyword for PHP files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "php",
	callback = function()
		vim.opt_local.iskeyword:append("$")
	end,
})

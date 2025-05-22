return {
	"echasnovski/mini.bufremove",
	version = "*",
	opts = {},
	config = function()
		local miniRemove = require("mini.bufremove")
		local special_filetypes = {
			"lazy",
			"qf", -- quickfix
			"copilot-chat",
			"harpoon",
		}

		vim.keymap.set("n", "<leader>w", function()
			local win = vim.api.nvim_get_current_win()
			local buf = vim.api.nvim_get_current_buf()
			local current_ft = vim.bo[buf].filetype
			local wins_in_tab = vim.fn.winnr("$")

			if wins_in_tab > 1 then
				-- If there are splits, just close the current window
				vim.cmd("q")
			elseif
                -- Handle special file types
				vim.api.nvim_win_get_config(win).relative ~= "" or vim.tbl_contains(special_filetypes, current_ft)
			then
				vim.cmd("bdelete!") -- Force close special windows
			else
				miniRemove.delete()
			end
		end, { silent = true })
		vim.keymap.set("n", "<leader>q", function()
			local win = vim.api.nvim_get_current_win()
			local buf = vim.api.nvim_get_current_buf()
			local current_ft = vim.bo[buf].filetype
			local wins_in_tab = vim.fn.winnr("$")

			if wins_in_tab > 1 then
				-- If there are splits, just close the current window
				vim.cmd("q")
			elseif
                -- Handle special file types
				vim.api.nvim_win_get_config(win).relative ~= "" or vim.tbl_contains(special_filetypes, current_ft)
			then
				vim.cmd("bdelete!") -- Force close special windows
			else
				miniRemove.delete()
			end
		end, { silent = true })
	end,
}

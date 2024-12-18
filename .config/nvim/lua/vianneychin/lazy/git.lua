return {
	{
		"tpope/vim-fugitive",

		config = function()
			vim.opt.statusline = "%<%f\\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\\ %P"
		end,
		-- :0Gllog
		-- Browse through the history of a file
		-- Can cycle though with :lnext and :lprevious. Close via :lclose
		--
		-- :G log %
		-- Viewing the commits of a file.
		--
		-- :G blame %
		--
		-- :[range] Gllog
		-- View the specific range of lines history change via log
		--
		-- :Gedit
		-- To go back to the current version of any file
		--
		-- :Gedit !
		-- Reach last commit that has touched the current file
		-- Ideally we see this in the diff view though.
		-- Current process is doing, :G then dv to open diff view
		--
		--
		-- Useful commands in the :G status window
		-- cw to reword last ocmmit
		-- ca to ammend the last commit
		-- cd to create a fixup commit
		-- crc to rever the commit under the cursor
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
		config = function()
			local gitsigns = require("gitsigns")
			gitsigns.setup({
				-- TODO: Create a keybind to open the file, <leader>o(?)
				vim.keymap.set("v", "<leader>hr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Selected [H]unk gets [R]eset." }),
				vim.keymap.set("v", "<leader>hs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "Selected [H]unk gets [S]taged." }),
				vim.keymap.set(
					"n",
					"<leader>tb",
					gitsigns.toggle_current_line_blame,
					{ desc = "[T]oggle Git Line [B]lame" }
				),
			})
		end,
	},
}

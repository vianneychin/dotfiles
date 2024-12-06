return {
	{
		"tpope/vim-fugitive",
	},
	-- https://www.reddit.com/r/neovim/comments/1h8aekd/vimfugitive_is_just_a_superior_way_to_manage_your/
	-- Perhaps retry vim-fugitive, it looks like it already has a pretty
	-- intuitive ui to see diff changes
	-- Just need to find the hotkeys for resetting changes, stagings, etc.
	{
		"sindrets/diffview.nvim",
		config = function()
			vim.keymap.set("n", "<leader>gg", "<Cmd>DiffviewOpen<CR>")
			vim.keymap.set("n", "<leader>GG", "<Cmd>DiffviewClose<CR>")

			require("diffview").setup({
				keymaps = {
					view = {
						-- Restore entire file to original
						["<leader>RR"] = function()
							local actions = require("diffview.actions")
							actions.restore_entry()
						end,
						-- Restore selected ranges
					},
				},
			})
		end,
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

return {
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local actions = require("diffview.actions")
			require("diffview").setup({
                use_icons = true,
				file_panel = {
					listing_style = "list",
				},
			})

			vim.keymap.set(
				"n",
				"<leader>gf",
				"<cmd>DiffviewFileHistory --follow %<cr>",
				{ desc = "Git [F]ile history" }
			)
			vim.keymap.set("n", "<leader>gl", "<Cmd>.DiffviewFileHistory --follow<CR>", { desc = "Git [L]ine history" })

			-- Diff against remote master branch
			vim.keymap.set("n", "<leader>gg", function()
				if next(require("diffview.lib").views) == nil then
					vim.cmd("DiffviewOpen")
				else
					vim.cmd("DiffviewClose")
				end
			end)
		end,
	},
	{
		"tpope/vim-fugitive",

		config = function()
			-- Open Fugitive in a vertical split on the right
			vim.keymap.set("n", "<leader>G", function()
				vim.cmd("horizontal botright Git")
			end, { desc = "Open Fugitive" })

			-- Open Git commit in a vertical split on the right
			vim.keymap.set("n", "<leader>CC", function()
				vim.cmd("horizontal botright Git commit")
			end, { desc = "Git Commit" })
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

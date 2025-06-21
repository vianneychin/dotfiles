---@module "snacks"

-- Helper functions for Snacks pickers
local function search_files()
	local current_buf = vim.api.nvim_buf_get_name(0)
	local opts = {
		formatters = {
			file = { filename_first = true },
		},
		filter = {
			cwd = true,
		},
		layout = { preview = false },
	}

	-- Check if we're in a CodeCompanion buffer
	if vim.bo.filetype == "codecompanion" then
		local codecompanion_win = vim.api.nvim_get_current_win()
		opts.confirm = function(picker, item)
			picker:close()
			vim.api.nvim_set_current_win(codecompanion_win)
			if item then
				local file_path = item.text or item.file
				if file_path then
					-- Split by spaces and use only the last part (the desired path)
					local parts = vim.split(file_path, " ", { plain = true })
					local chosen = parts[#parts]

					-- Use the /file slash command for CodeCompanion
					-- Insert at current cursor position
					vim.api.nvim_put({ "/file " .. chosen }, "", true, true)

					-- Alternatively, if you want to use the #buffer variable:
					-- vim.api.nvim_put({ "#buffer " .. chosen }, "", true, true)
				end
			end
		end
	end
	Snacks.picker.smart(opts)
end

local function grep_files()
	Snacks.picker.grep({
		live = true,
		exclude = { "_ide_helper.php", "_ide_helper_models.php", "composer.lock" },
		formatters = {
			file = {
				filename_first = true,
			},
		},
		previewer = {
			file = { treesitter = { enabled = true } },
			layout = {
				width = 0.9,
			},
		},
	})
end

local function buffers_picker()
	local opts = {
		formatters = {
			file = { filename_first = true },
		},
	}
	Snacks.picker.buffers(opts)
end

local function keymaps_picker()
	Snacks.picker.keymaps()
end

return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	---@type snacks.Config
	opts = {
		picker = {
			exclude = {
				"node_modules",
				"vendor",
				".git",
			},
			sources = {
				grep = {
					win = {
						preview = {
							width = 0.8,
							height = 200,
						},
					},
					layout = {
						border = "none",
						-- fullscreen = true,
						box = "vertical",
						layout = {
							backdrop = false,
							-- row = 1,
							width = 0.99,
							-- min_width = 80,
							height = 0.99,
							border = "none",
							box = "vertical",
							{
								win = "input",
								height = 1,
								border = "rounded",
								title = "{title} {live} {flags}",
								title_pos = "center",
							},
							{ win = "list", border = "single", height = 0.2 },
							{ win = "preview", title = "{preview}", border = "single" },
						},
					},
				},
				recent = {
					layout = {
						border = "none",
						preview = nil,
						layout = {
							width = 0.5,
							max_width = 90,
							height = 0.4,
							min_height = 10,
						},
					},
				},
				buffers = {
					layout = {
						preview = false,
						layout = {
							width = 0.5,
							border = "none",
							max_width = 90,
							height = 0.4,
							min_height = 10,
						},
					},
				},
				smart = {
					layout = {
						preview = nil,
						layout = {
							width = 0.5,
							border = "none",
							max_width = 90,
							height = 0.4,
							min_height = 10,
						},
					},
				},
			},
		},

		image = {
			enabled = false,
		},

		-- indent = {
		-- 	animate = {
		-- 		enabled = false,
		-- 	},
		-- 	indent = {
		-- 		hl = "SnacksIndent7",
		-- 		only_scope = true,
		-- 		only_current = true,
		-- 	},
		-- 	enabled = true,
		-- 	chunk = {
		-- 		enabled = false,
		-- 	},
		-- },
	},
	keys = {
		-- Start Snacks.picker config
		{ "<leader>sf", search_files, desc = "Search files" },
		{ "<leader>p", search_files, desc = "Search files" },
		{ "<leader>F", grep_files, desc = "Grep word throughout all files" },
		{ "<leader>sg", grep_files, desc = "Grep word throughout all files" },
		{ "<leader>sb", buffers_picker, desc = "[ ] Find existing buffers" },
		{ "<leader>ks", keymaps_picker, desc = "[S]earch [K]eymaps" },
		{ "<leader>sk", keymaps_picker, desc = "[S]earch [K]eymaps" },
		{
			"<leader>so",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "[S]earch Symb[o]ls / Functions",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "[S]earch [D]iagnostics",
		},
		{
			"<leader>sr",
			function()
				Snacks.picker.resume()
			end,
			desc = "[S]earch [R]esume",
		},
		{
			"<leader>s.",
			function()
				Snacks.picker.recent()
			end,
			desc = '[S]earch Recent Files ("." for repeat)',
		},
	},
}

---@module "snacks"

-- Helper functions for Snacks pickers
local function search_files()
	local current_buf = vim.api.nvim_buf_get_name(0)
	local opts = {
		formatters = {
			file = { filename_first = true },
		},
		layout = { preview = false },
	}
	if current_buf:match("copilot%-chat") then
		local copilot_win = vim.api.nvim_get_current_win()
		opts.confirm = function(picker, item)
			picker:close()
			vim.api.nvim_set_current_win(copilot_win)
			if item then
				local file_path = item.text or item.file
				if file_path then
					-- Split by spaces and use only the last part (the desired path)
					local parts = vim.split(file_path, " ", { plain = true })
					local chosen = parts[#parts]
					-- Insert the chosen file path followed by two new (empty) lines.
					vim.api.nvim_put({ "#file:" .. chosen, "", "" }, "", true, true)
				end
			end
		end
	end
	Snacks.picker.smart(opts)
end

local function grep_files()
	Snacks.picker.grep({
		live = true,
		exclude = { "_ide_helper.php", "_ide_helper_models.php" },
		formatters = {
			file = {
				filename_first = true,
			},
		},
		previewer = {
			-- file = { treesitter = { enabled = false } },
			layout = {
				width = 0.9,
			},
		},
	})
end

local function buffers_picker()
	Snacks.picker.buffers({})
end

local function keymaps_picker()
	Snacks.picker.keymaps()
end

return {
	"folke/snacks.nvim",

	---@type snacks.Config
	opts = {
		picker = {
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
						preview = false,
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
						border = "none",
						preview = false,
						layout = {
							width = 0.5,
							max_width = 90,
							height = 0.4,
							min_height = 10,
						},
					},
				},
				smart = {
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
			},
		},
	},
	keys = {
		{
			"<leader>z",
			function()
				Snacks.zen()
			end,
			desc = "Toggle Zen Mode",
		},
		{
			"<leader>Z",
			function()
				Snacks.zen.zoom()
			end,
			desc = "Toggle Zoom",
		},
		{ "<leader>sf", search_files, desc = "Search files" },
		{ "<leader>p", search_files, desc = "Search files" },
		{ "<leader>F", grep_files, desc = "Grep word throughout all files" },
		{ "<leader>sg", grep_files, desc = "Grep word throughout all files" },
		{ "<leader>sb", buffers_picker, desc = "[ ] Find existing buffers" },
		{ "<leader>b", buffers_picker, desc = "[ ] Find existing buffers" },
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

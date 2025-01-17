return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
		config = function()
			require("render-markdown").setup({
				file_types = { "markdown", "copilot-chat" },
			})
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			-- { "github/copilot.vim" },
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		keys = {
			{
				"<leader>cc",
				":CopilotChatToggle<CR>",
				mode = { "n", "x" },
				desc = "CopilotChat",
			},
		},
		config = function()
			require("CopilotChat").setup({
				highlight_headers = false,
				separator = "---",
				error_header = "> [!ERROR] Error",
				window = {
					width = 0.35,
				},
				mappings = {
					close = {
						normal = "q",
						insert = "<C-q>",
					},
					submit_prompt = {
						normal = "<C-s>",
						insert = "<C-s>",
					},
				},
			})
			vim.keymap.set("n", "<leader>cq", function()
				local input = vim.fn.input("Quick Chat: ")
				if input ~= "" then
					require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
				end
			end)
		end,
	},
}

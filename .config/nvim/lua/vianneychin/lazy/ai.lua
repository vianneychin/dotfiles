return {
	-- {
	-- 	"olimorris/codecompanion.nvim",
	-- 	opts = {},
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 	},
	-- 	config = function()
	-- 		require("codecompanion").setup({
	-- 			adapters = {
	-- 				anthropic = function()
	-- 					return require("codecompanion.adapters").extend("anthropic", {
	-- 						env = {
	-- 							api_key = "",
	-- 						},
	-- 						-- env = {
	-- 						-- 	api_key = "cmd:op read op://personal/OpenAI/credential --no-newline",
	-- 						-- },
	-- 					})
	-- 				end,
	-- 			},
	-- 			strategies = {
	-- 				chat = {
	-- 					slash_commands = {
	-- 						["buffer"] = {
	-- 							opts = {
	-- 								provider = "snacks",
	-- 							},
	-- 						},
	-- 						["file"] = {
	-- 							opts = {
	-- 								provider = "snacks",
	-- 							},
	-- 						},
	-- 					},
	-- 					adapter = "anthropic",
	-- 					keymaps = {
	-- 						send = {
	-- 							modes = { n = "<C-s>", i = "<C-s>" },
	-- 						},
	-- 						close = {
	-- 							modes = {
	-- 								n = "<leader>q",
	-- 								i = "<leader>q",
	-- 							},
	-- 						},
	-- 					},
	-- 					-- variables = {
	-- 					-- 	-- https://codecompanion.olimorris.dev/configuration/chat-buffer.html#variables
	-- 					-- 	["harpoon"] = {
	-- 					-- 		callback = function()
	-- 					-- 			return "TODO: Give all my harpoon files"
	-- 					-- 		end,
	-- 					-- 		description = "Use all my harpoon files as context",
	-- 					-- 		opts = {
	-- 					-- 			contains_code = true,
	-- 					-- 		},
	-- 					-- 	},
	-- 					-- },
	-- 				},
	-- 			},
	-- 		})
	-- 		vim.api.nvim_set_keymap(
	-- 			"n",
	-- 			"<leader>cc",
	-- 			"<cmd>CodeCompanionChat Toggle<cr>",
	-- 			{ noremap = true, silent = true }
	-- 		)
	-- 		-- vim.api.nvim_set_keymap("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
	-- 		-- vim.api.nvim_set_keymap(
	-- 		-- 	{ "n", "v" },
	-- 		-- 	"<C-a>",
	-- 		-- 	"<cmd>CodeCompanionActions<cr>",
	-- 		-- 	{ noremap = true, silent = true }
	-- 		-- )
	-- 	end,
	-- },

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			-- { "github/copilot.vim" }, -- only enable temporarily to authenticate
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
				model = "claude-3.5-sonnet",
				highlight_headers = false,
				separator = "---",
				error_header = "> [!ERROR] Error",
				window = {
					width = 0.35,
				},
				selection = require("CopilotChat.select").buffer,
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
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
		config = function()
			require("render-markdown").setup({
				file_types = { "markdown", "copilot-chat", "codecompanion", "todo" },
			})
		end,
	},
}

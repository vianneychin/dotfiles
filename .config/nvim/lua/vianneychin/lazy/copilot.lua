return {
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
		mappings = {
			close = {
				-- Remove default CTRL+c keybinding to close window
				insert = "",
			},
			submit_prompt = {
				normal = "<C-CR>",
				insert = "<C-CR>",
			},
		},
		config = function()
			-- TODO:
			-- Keymaps:
			-- -
			require("CopilotChat").setup({
				-- chat_autcomplete = false,
                window = {
                    width = 0.35
                }
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

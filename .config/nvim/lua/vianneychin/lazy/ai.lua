return {
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({})
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		opts = {},
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
			{ "nvim-lua/plenary.nvim" },
			{ "saghen/blink.cmp", lazy = false, version = "*" },
		},
		config = function()
			require("codecompanion").setup({
				adapters = {
					anthropic = function()
						local get_anthropic_api_key = function()
							local file_path = os.getenv("HOME") .. "/anthropic/key.txt"
							local f = io.open(file_path, "rb")
							if not f then
								print("Failed to open Anthropic API key file")
								return ""
							end

							local content = f:read("*a")
							f:close()

							local api_key = string.gsub(content, "%s+", "")
							return api_key
						end
						return require("codecompanion.adapters").extend("anthropic", {
							env = {
								api_key = get_anthropic_api_key(),
							},
						})
					end,
				},
				strategies = {
					chat = {
						variables = {
							["buffer"] = {
								opts = {
									default_params = "pin",
								},
							},
						},
						slash_commands = {
							["file"] = {
								keymaps = {
									modes = {
										i = "<C-b>",
										n = { "<leader>p", "gb" },
									},
								},
								opts = {
									provider = "snacks",
								},
							},
						},
						adapter = "anthropic",
						keymaps = {
							send = {
								modes = { n = "<C-s>", i = "<C-s>" },
							},
							clear = {
								modes = {
									n = "<C-l>",
								},
								description = "Clear the chat buffer",
							},
							close = {
								modes = {
									n = "<leader>q",
									i = "<leader>q",
								},
							},
						},
					},
				},
			})
			vim.api.nvim_set_keymap(
				"n",
				"<leader>cc",
				"<cmd>CodeCompanionChat Toggle<cr>",
				{ noremap = true, silent = true }
			)
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "codecompanion" },
	},
	{
		"HakonHarnes/img-clip.nvim",
		opts = {
			filetypes = {
				codecompanion = {
					prompt_for_file_name = false,
					template = "[Image]($FILE_PATH)",
					use_absolute_path = true,
				},
			},
		},
	},
}

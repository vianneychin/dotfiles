return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter-context" },
	opts = {
		previewers = {
			builtin = {
				-- With this change, the previewer will not add syntax
				-- highlighting to files larger than 100KB
				syntax_limit_b = 1024 * 100, -- 100KB
			},
		},
	},
	config = function()
		local fzfLua = require("fzf-lua")
		local keymap = vim.keymap
		-- https://github.com/deathbeam/dotfiles/blob/master/nvim/.config/nvim/lua/config/finder.lua#L43
		fzfLua.setup({
			keymap = {
				fzf = {
					["ctrl-q"] = "select-all+accept",
				},
			},
            --
			-- defaults = {
			-- 	formatter = { "path.filename_first", 2 },
			-- 	multiline = 1,
			-- },

			grep = {
				rg_opts = ' --hidden --glob "!.git/" --glob "!_ide_helper.php" --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e',
				no_column_hide = true,
			},

			lsp = {
				code_actions = {
					fzf_opts = {
						["--tmux"] = "bottom,50%",
					},
				},
			},

			vim.keymap.set("n", "<leader>p", function()
				local current_buf = vim.api.nvim_buf_get_name(0)

				local fzf_opts = {
					winopts = {
						border = "none",
						height = 0.35,
						width = 0.65,
						preview = { layout = "vertical", delay = 50 },
					},
					previewer = false,
				}

				if current_buf:match("copilot%-chat") then
					fzf_opts.path = "absolute"
					fzf_opts.file_icons = false
					fzf_opts.git_icons = false
					fzf_opts.actions = {
						["default"] = function(selected, _)
							local file_path = selected[1]
							if file_path then
								-- Get the current directory
								local current_dir = vim.fn.getcwd()
								-- Concatenate the current_dir with the file_path
								local custom_path = current_dir .. "/" .. file_path

								vim.api.nvim_put({ "#file:" .. custom_path }, "", false, true)
							end
						end,
					}
				end

				require("fzf-lua").files(fzf_opts)
			end, { desc = "Search files" }),

			keymap.set("n", "<leader>F", function()
				fzfLua.live_grep({
					resume = true,
					winopts = {
						treesitter = false,
						preview = { delay = 150 },
						height = 0.95,
						width = 0.95,
					},
					previewer = {
						treesitter = {
							enabled = false,
						},
					},
				})
			end, { desc = "Grep word throughout all files" }),
			keymap.set("n", "<leader>b", function()
				fzfLua.buffers({
					winopts = {
						border = "none",
						height = 0.35,
						width = 0.65,
						preview = { layout = "vertical", delay = 10 },
					},
					previewer = false,
				})
			end, { desc = "[ ] Find existing buffers" }),
			keymap.set("n", "<leader>ks", fzfLua.keymaps, { desc = "[S]earch [K]eymaps" }),
			keymap.set("n", "<leader>so", fzfLua.lsp_document_symbols, { desc = "[S]earch Symb[o]ls / Functions" }),
			keymap.set("n", "<leader>sd", fzfLua.diagnostics_document, { desc = "[S]earch [D]iagnostics" }),
			keymap.set("n", "<leader>sr", fzfLua.resume, { desc = "[S]earch [R]esume" }),
			keymap.set("n", "<leader>s.", fzfLua.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' }),
			-- keymap.set("n", "gD", fzfLua.lsp_declarations, {}),
			-- keymap.set("n", "gd", fzfLua.lsp_definitions, {}),
		})
	end,
}

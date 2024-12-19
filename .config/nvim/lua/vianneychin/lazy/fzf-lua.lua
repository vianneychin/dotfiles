return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter-context" },
	opts = {
        oldfiles = {
            include_current_session = true,
        },
        previewers = {
            builtin = {
                -- With this change, the previewer will not add syntax
                -- highlighting to files larger than 100KB
                syntax_limit_b = 1024 * 100, -- 100KB
            }
        },
    },
	config = function()
		local fzfLua = require("fzf-lua")
        local keymap = vim.keymap;
		fzfLua.setup({
			vim.keymap.set("n", "<leader>p", function()
				-- winopts.preview.delay = 0
				fzfLua.files({
					cmd = "rg --files --hidden",
					winopts = {
						border = "none",
						height = 0.35,
						width = 0.65,
						preview = { layout = "vertical", delay = 10 },
					},
					previewer = false,
				})
			end, { desc = "[S]earch [F]iles" }),
			keymap.set("n", "<leader>F", function()
				fzfLua.live_grep({
					search = "",
					formatter = "path.filename_first",
					cmd = "rg --color=always --smart-case --hidden --column -e",
					winopts = {
						treesitter = false,
						preview = { delay = 10 },
						height = 0.95,
						width = 0.95,
					},
					previewer = {
						treesitter = {
							enabled = false,
						},
					},
				})
			end, { desc = "[S]earch [F]iles" }),
			keymap.set("n", "<leader>b", function()
				fzfLua.buffers({
					cmd = "rg --files --hidden",
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
		})
	end,
}

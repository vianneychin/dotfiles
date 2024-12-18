return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzfLua = require("fzf-lua")
		fzfLua.setup({
			fzfLua = require("fzf-lua"),
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
			vim.keymap.set("n", "<leader>F", function()
				fzfLua.live_grep({
					search = "",
					formatter = "path.filename_first",
					cmd = "rg --color=always --smart-case --hidden --column -e",
					winopts = {
						treesitter = true,
						preview = { delay = 10 },
						height = 0.95,
						width = 0.95,
					},
				})
			end, { desc = "[S]earch [F]iles" }),
			vim.keymap.set("n", "<leader>b", function()
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
			vim.keymap.set("n", "<leader>ks", fzfLua.keymaps, { desc = "[S]earch [K]eymaps" }),
			vim.keymap.set("n", "<leader>so", fzfLua.lsp_document_symbols, { desc = "[S]earch Symb[o]ls / Functions" }),
			vim.keymap.set("n", "<leader>sd", fzfLua.diagnostics_document, { desc = "[S]earch [D]iagnostics" }),
			vim.keymap.set("n", "<leader>sr", fzfLua.resume, { desc = "[S]earch [R]esume" }),
			vim.keymap.set("n", "<leader>s.", fzfLua.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' }),
		})
	end,
}

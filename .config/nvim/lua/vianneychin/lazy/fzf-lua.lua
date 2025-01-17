return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter-context" },
	opts = {
		-- oldfiles = {
		--     include_current_session = true,
		-- },
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
		-- https://github.com/ibhagwan/fzf-lua/issues/602
		local function w(fn)
			return function(...)
				return fn({
					ignore_current_line = true,
					jump_to_single_result = true,
					includeDeclaration = false,
				}, ...)
			end
		end
		-- https://github.com/deathbeam/dotfiles/blob/master/nvim/.config/nvim/lua/config/finder.lua#L43
		vim.lsp.handlers["textDocument/codeAction"] = w(fzfLua.lsp_code_actions)
		vim.lsp.handlers["textDocument/definition"] = w(fzfLua.lsp_definitions)
		vim.lsp.handlers["textDocument/declaration"] = w(fzfLua.lsp_declarations)
		vim.lsp.handlers["textDocument/typeDefinition"] = w(fzfLua.lsp_typedefs)
		vim.lsp.handlers["textDocument/implementation"] = w(fzfLua.lsp_implementations)
		vim.lsp.handlers["textDocument/references"] = w(fzfLua.lsp_references)
		vim.lsp.handlers["textDocument/documentSymbol"] = w(fzfLua.lsp_document_symbols)
		vim.lsp.handlers["workspace/symbol"] = w(fzfLua.lsp_workspace_symbols)
		vim.lsp.handlers["callHierarchy/incomingCalls"] = w(fzfLua.lsp_incoming_calls)
		vim.lsp.handlers["callHierarchy/outgoingCalls"] = w(fzfLua.lsp_outgoing_calls)
		fzfLua.register_ui_select({
			winopts = {
				height = 0.35,
				width = 0.65,
				preview = { layout = "vertical", delay = 50 },
			},
			fzf_opts = {
				["--prompt"] = "UISelect> ",
				-- fzf_opts = {
				-- 	["--tmux"] = "bottom,50%",
				-- },
			},
		})
		fzfLua.setup({
			keymap = {
				fzf = {
					["ctrl-q"] = "select-all+accept",
				},
			},
			vim.keymap.set("n", "<leader>p", function()
				-- winopts.preview.delay = 0
				fzfLua.files({
					formatter = "path.filename_first",
					cmd = "rg --files --hidden --glob '!.git/**'",
					winopts = {
						border = "none",
						height = 0.35,
						width = 0.65,
						preview = { layout = "vertical", delay = 50 },
					},
					previewer = false,
				})
			end, { desc = "[S]earch [F]iles" }),
			keymap.set("n", "<leader>F", function()
				fzfLua.live_grep({
					formatter = "path.filename_first",
					resume = true,
					-- cmd = "rg --files --hidden --glob '!.git/**'",
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
			end, { desc = "[S]earch [F]iles" }),
			keymap.set("n", "<leader>b", function()
				fzfLua.buffers({
					formatter = "path.filename_first",
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
			keymap.set("n", "gD", fzfLua.lsp_declarations, {}),
			keymap.set("n", "gd", fzfLua.lsp_definitions, {}),
		})
	end,
}

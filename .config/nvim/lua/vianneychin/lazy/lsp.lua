return {
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			{ "williamboman/mason-lspconfig.nvim" },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
			{ "saghen/blink.cmp" },
			{ "j-hui/fidget.nvim", opts = {} },
			"stevearc/conform.nvim",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/nvim-cmp",
		},

		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					vim.lsp.handlers["textDocument/publishDiagnostics"] =
						vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
							underline = true,
							update_in_insert = false,
							virtual_text = { spacing = 2 },
							severity_sort = true,
						})

					vim.cmd([[
                        highlight DiagnosticUnderlineError cterm=undercurl gui=undercurl guisp=Red blend=50
                        highlight DiagnosticUnderlineWarn cterm=undercurl gui=undercurl guisp=Yellow blend=50
                    ]])

					vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", {})
					vim.keymap.set("n", "gd", function()
						-- Get list of locations
						vim.lsp.buf.definition({
							on_list = function(options)
								-- Filter out ide_helper files
								if options and options.items then
									local filtered_items = vim.tbl_filter(function(item)
										return not string.match(item.filename or "", "ide_helper")
									end, options.items)

									options.items = filtered_items
									vim.fn.setqflist({}, " ", options)

									if #filtered_items == 1 then
										-- If only one location, jump to it directly
										vim.cmd("cfirst")
									elseif #filtered_items > 1 then
										-- If multiple locations, show quickfix list
										vim.cmd("copen")
									end
								end
							end,
						})
					end, { buffer = event.buf })
					vim.api.nvim_set_keymap("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", {})

					-- vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.rename()<CR>", {})
					vim.keymap.set("n", "gr", function()
						-- when rename opens the prompt, this autocommand will trigger
						-- it will "press" CTRL-F to enter the command-line window `:h cmdwin`
						-- in this window I can use normal mode keybindings
						local cmdId
						cmdId = vim.api.nvim_create_autocmd({ "CmdlineEnter" }, {
							callback = function()
								local key = vim.api.nvim_replace_termcodes("<C-f>", true, false, true)
								vim.api.nvim_feedkeys(key, "c", false)
								vim.api.nvim_feedkeys("0", "n", false)
								-- autocmd was triggered and so we can remove the ID and return true to delete the autocmd
								cmdId = nil
								return true
							end,
						})
						vim.lsp.buf.rename()
						-- if LPS couldn't trigger rename on the symbol, clear the autocmd
						vim.defer_fn(function()
							-- the cmdId is not nil only if the LSP failed to rename
							if cmdId then
								vim.api.nvim_del_autocmd(cmdId)
							end
						end, 500)
					end, { silent = true, desc = "Rename symbol" })
				end,
			})

			local capabilities = require("blink.cmp").get_lsp_capabilities()
			require("lspconfig").lua_ls.setup({ capabilities = capabilities })
			local servers = {
				-- See `:help lspconfig-all`
				["php-cs-fixer"] = {},
				intelephense = {
					init_options = {
						licenceKey = "0084ZCGFUE12XWS",
					},
				},
				["blade-formatter"] = {
					filetypes = { "blade" },
				},

				-- ["vue-language-server"] = {},
				["vetur-vls"] = {},
				rust_analyzer = {},
				jsonls = {},
				ts_ls = {},
				vtsls = {
					filetypes = {
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
					},
					settings = {
						complete_function_calls = true,
						vtsls = {
							enableMoveToFileCodeAction = true,
							autoUseWorkspaceTsdk = true,
							experimental = {
								maxInlayHintLength = 30,
								completion = {
									enableServerSideFuzzyMatch = true,
								},
							},
						},
						typescript = {
							updateImportsOnFileMove = { enabled = "always" },
							suggest = {
								completeFunctionCalls = true,
							},
							inlayHints = {
								enumMemberValues = { enabled = true },
								functionLikeReturnTypes = { enabled = true },
								parameterNames = { enabled = "literals" },
								parameterTypes = { enabled = true },
								propertyDeclarationTypes = { enabled = true },
								variableTypes = { enabled = false },
							},
						},
					},
				},
				["html-lsp"] = {},
				cssls = {},
				lua_ls = {
					settings = {
						Lua = {
							workspace = { checkThirdParty = false },
							telemetry = { enable = false },
							diagnostics = {
								disable = { "missing-fields" },
							},
						},
					},
				},
			}

			--  You can press `g?` for help in this menu.
			require("mason").setup()

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua",
				"prettier",
				"prettierd",
				"eslint_d",
				-- "eslint-lsp",
			})

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
}

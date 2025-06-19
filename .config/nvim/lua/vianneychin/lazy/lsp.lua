return {
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
			{ "saghen/blink.cmp" },
			{ "j-hui/fidget.nvim", opts = {} },
			"stevearc/conform.nvim",
			-- "L3MON4D3/LuaSnip",
			-- "saadparwaiz1/cmp_luasnip",
		},

		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					vim.lsp.handlers["textDocument/publishDiagnostics"] =
						vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
							underline = true,
							update_in_insert = true,
							virtual_text = { spacing = 2 },
							severity_sort = true,
						})

					-- Makes background of the LSP messages to be transparent
					vim.cmd([[
                        highlight DiagnosticVirtualTextError guibg=NONE
                        highlight DiagnosticVirtualTextWarn guibg=NONE
                        highlight DiagnosticVirtualTextInfo guibg=NONE
                        highlight DiagnosticVirtualTextHint guibg=NONE
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
										vim.cmd("cfirst | normal! zz")
									elseif #filtered_items > 1 then
										-- If multiple locations, show quickfix list
										vim.cmd("copen | normal! zz")
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

					vim.lsp.buf.format = function(options)
						local util = require("vim.lsp.util")
						options = options or {}
						local bufnr = options.bufnr or vim.api.nvim_get_current_buf()
						local clients = vim.lsp.buf_get_clients(bufnr)

						if options.filter then
							clients = options.filter(clients)
						elseif options.id then
							clients = vim.tbl_filter(function(client)
								return client.id == options.id
							end, clients)
						elseif options.name then
							clients = vim.tbl_filter(function(client)
								return client.name == options.name
							end, clients)
						end

						clients = vim.tbl_filter(function(client)
							return client.supports_method("textDocument/formatting")
						end, clients)

						if #clients == 0 then
							vim.notify("[LSP] Format request failed, no matching language servers.")
						end

						local timeout_ms = options.timeout_ms or 1000
						for _, client in pairs(clients) do
							local params = util.make_formatting_params(options.formatting_options)
							local result, err =
								client.request_sync("textDocument/formatting", params, timeout_ms, bufnr)
							if result and result.result then
								util.apply_text_edits(result.result, bufnr, client.offset_encoding)
							elseif err then
								vim.notify(string.format("[LSP][%s] %s", client.name, err), vim.log.levels.WARN)
							end
						end
					end
				end,
			})
			local get_intelephense_license = function()
				local f = assert(io.open(os.getenv("HOME") .. "/intelephense/licence.txt", "rb"))
				local content = f:read("*a")
				f:close()
				return string.gsub(content, "%s+", "")
			end

			local capabilities = require("blink.cmp").get_lsp_capabilities()
			require("lspconfig").lua_ls.setup({ capabilities = capabilities })
			local servers = {
				-- cspell = {},
				-- See `:help lspconfig-all`
				-- ["php-cs-fixer"] = {},
				intelephense = {
					init_options = {
						licenceKey = get_intelephense_license(),
					},
				},
				["blade-formatter"] = {
					filetypes = { "blade" },
				},
				ts_ls = {
					-- single_file_support = false,
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "literal",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},

				jsonls = {},
				-- ts_ls = {},
				eslint = {
					-- filetypes = {
					-- 	"vue",
					-- 	"javascript",
					-- },
					filetypes = {
						"html",
						"css",
						"scss",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"vue",
						"blade",
					},
				},
				tailwindcss = {
					filetypes = {
						"html",
						"css",
						"scss",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"vue",
						"blade",
					},
					init_options = {
						userLanguages = {
							blade = "html",
						},
					},
				},
				["html-lsp"] = {},
				cssls = {
					settings = {
						css = {
							validate = true,
							lint = {
								unknownAtRules = "ignore",
							},
						},
						scss = {
							validate = true,
							lint = {
								unknownAtRules = "ignore",
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
			})

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
                automatic_enable = true,
				ensure_installed = {},
				automatic_installation = false,
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

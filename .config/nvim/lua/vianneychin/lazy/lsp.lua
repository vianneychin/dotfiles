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
            vim.lsp.enable('laravel_ls')
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
						vim.lsp.buf.definition()
					end, { buffer = event.buf })
					vim.keymap.set("n", "ga", function()
						-- Use custom PHP handler for PHP files, default for others
						if vim.bo.filetype == "php" then
							local params = vim.lsp.util.make_range_params()
							params.context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }

							vim.lsp.buf_request(0, "textDocument/codeAction", params, function(err, result, ctx, config)
								if err or not result then
									return
								end

								-- Sort actions - codebase imports first, vendor imports middle, PHPDoc at bottom
								table.sort(result, function(a, b)
									local a_title = a.title or ""
									local b_title = b.title or ""

									-- Check if it's a PHPDoc action
									local a_is_doc = string.match(a_title, "PHPDoc")
										or string.match(a_title, "Add.*doc")
										or string.match(a_title, "Generate.*doc")
									local b_is_doc = string.match(b_title, "PHPDoc")
										or string.match(b_title, "Add.*doc")
										or string.match(b_title, "Generate.*doc")

									-- PHPDoc actions go to bottom
									if a_is_doc and not b_is_doc then
										return false
									elseif b_is_doc and not a_is_doc then
										return true
									elseif a_is_doc and b_is_doc then
										return false
									end

									-- Check if it's a vendor import (illuminate, symfony, etc.)
									local a_is_vendor = string.match(a_title, "Illuminate\\")
										or string.match(a_title, "Symfony\\")
										or string.match(a_title, "Laravel\\")
									local b_is_vendor = string.match(b_title, "Illuminate\\")
										or string.match(b_title, "Symfony\\")
										or string.match(b_title, "Laravel\\")

									-- Prioritize non-vendor (codebase) imports over vendor imports
									if not a_is_vendor and b_is_vendor then
										return true
									elseif a_is_vendor and not b_is_vendor then
										return false
									end

									return false
								end)
								local filtered_actions = result

								if #filtered_actions == 0 then
									vim.notify("No code actions available")
									return
								end

								vim.ui.select(filtered_actions, {
									prompt = "Code actions:",
									format_item = function(action)
										return action.title
									end,
								}, function(action)
									if action then
										vim.lsp.buf.execute_command(action.command or action)
									end
								end)
							end)
						else
							-- Use default code action for non-PHP files
							vim.lsp.buf.code_action()
						end
					end, { buffer = event.buf })

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
				local file_path = os.getenv("HOME") .. "/intelephense/licence.txt"
				local f = io.open(file_path, "rb")
				if not f then
					print("Failed to open Intelephense license file")
					return ""
				end

				local content = f:read("*a")
				f:close()

				local license = string.gsub(content, "%s+", "")
				return license
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
					settings = {
						intelephense = {},
					},
					on_attach = function(client, bufnr)
						vim.notify("Intelephense attached with license")
						if client.config.init_options and client.config.init_options.licenceKey then
							vim.notify("License key length: " .. #client.config.init_options.licenceKey)
						end
					end,
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

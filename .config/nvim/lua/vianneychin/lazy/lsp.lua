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
		},

		config = function()
			vim.filetype.add({
				pattern = {
					[".*%.blade%.php"] = "blade",
				},
			})
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", {})
					vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", {})
					vim.api.nvim_set_keymap("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", {})
					vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.rename()<CR>", {})
				end,
			})

			local capabilities = require("blink.cmp").get_lsp_capabilities()
			require("lspconfig").lua_ls.setup({ capabilities = capabilities })
			local servers = {
				-- See `:help lspconfig-all`
				["php-cs-fixer"] = {},
				intelephense = {},
				pint = {},
				["blade-formatter"] = {
					filetypes = { "blade" },
				},

				-- ["vue-language-server"] = {},
				["vetur-vls"] = {},
				rust_analyzer = {},
				jsonls = {},
				ts_ls = {
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
                "eslint_d"
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
	-- {
	-- 	"luckasRanarison/tailwind-tools.nvim",
	-- 	name = "tailwind-tools",
	-- 	build = ":UpdateRemotePlugins",
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"neovim/nvim-lspconfig",
	-- 	},
	-- 	opts = function()
	-- 		return {
	-- 			document_color = {
	-- 				enabled = false,
	-- 			},
	-- 		}
	-- 	end,
	-- },
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
	{
		-- Add the blade-nav.nvim plugin which provides Goto File capabilities
		-- for Blade files.
		"ricardoramirezr/blade-nav.nvim",
		dependencies = {
			"hrsh7th/nvim-cmp",
		},
		ft = { "blade", "php" },
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				-- javascript = { "eslint_d" },
				vue = { "eslint_d" },
				-- typescript = { "eslint_d" },
				-- javascriptreact = { "eslint_d" },
				-- typescriptreact = { "eslint_d" },
				-- php = { "phpstan" },
			}
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}

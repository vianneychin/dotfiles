return {
	{
		"saghen/blink.cmp",
		lazy = false, -- lazy loading handled internally
		-- optional: provides snippets for the snippet source
		dependencies = "rafamadriz/friendly-snippets",

		-- use a release tag to download pre-built binaries
		version = "v0.*",
		-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- see the "default configuration" section below for full documentation on how to define
			-- your own keymap.
			keymap = { preset = "default" },

			appearance = {
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- will be removed in a future release
				use_nvim_cmp_as_default = true,
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			-- default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, via `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				-- optionally disable cmdline completions
				-- cmdline = {},
			},

			-- experimental signature help support
			-- signature = { enabled = true }
		},
		-- allows extending the providers array elsewhere in your config
		-- without having to redefine it
		opts_extend = { "sources.default" },
	},
	-- {
	--     'hrsh7th/nvim-cmp',
	--     event = 'InsertEnter',
	--     dependencies = {
	--         -- Snippet Engine & its associated nvim-cmp source
	--         {
	--             'L3MON4D3/LuaSnip',
	--             build = (function()
	--                 -- Build Step is needed for regex support in snippets.
	--                 -- This step is not supported in many windows environments.
	--                 -- Remove the below condition to re-enable on windows.
	--                 if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
	--                     return
	--                 end
	--                 return 'make install_jsregexp'
	--             end)(),
	--         },
	--         'saadparwaiz1/cmp_luasnip',
	--
	--         -- Adds other completion capabilities.
	--         --  nvim-cmp does not ship with all sources by default. They are split
	--         --  into multiple repos for maintenance purposes.
	--         'hrsh7th/cmp-nvim-lsp',
	--         'hrsh7th/cmp-path',
	--     },
	--     config = function()
	--         -- See `:help cmp`
	--         local cmp = require 'cmp'
	--         local luasnip = require 'luasnip'
	--         luasnip.config.setup {}
	--
	--         cmp.setup {
	--             snippet = {
	--                 expand = function(args)
	--                     luasnip.lsp_expand(args.body)
	--                 end,
	--             },
	--             completion = { completeopt = 'menu,menuone,noinsert' },
	--
	--             -- For an understanding of why these mappings were
	--             -- chosen, you will need to read `:help ins-completion`
	--             --
	--             -- No, but seriously. Please read `:help ins-completion`, it is really good!
	--             mapping = cmp.mapping.preset.insert {
	--                 -- Scroll the documentation window [b]ack / [f]orward
	--                 ['<C-b>'] = cmp.mapping.scroll_docs(-4),
	--                 ['<C-f>'] = cmp.mapping.scroll_docs(4),
	--
	--                 -- Enter to select completion
	--                 ['<C-y>'] = cmp.mapping.confirm { select = true },
	--                 ['<C-n>'] = cmp.mapping.select_next_item(),
	--                 ['<C-p'] = cmp.mapping.select_prev_item(),
	--
	--                 -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
	--                 --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
	--             },
	--             sources = {
	--                 {
	--                     name = 'lazydev',
	--                     -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
	--                     group_index = 0,
	--                 },
	--                 { name = 'nvim_lsp' },
	--                 { name = 'luasnip' },
	--                 { name = 'path' },
	--             },
	--         }
	--     end,
	-- },
}

local o = vim.opt

o.nu = true -- Enable line numbers
o.relativenumber = true -- Enable relative line numbering from cursor position
o.cursorline = true
o.tabstop = 4 --  Number of spaces per tab character
o.shiftwidth = 4 -- When set to 0, shiftwidth will automatically match tabstop
o.smarttab = true
o.expandtab = true -- Converts tab to spaces
o.autoindent = true
o.smartindent = true -- Smart indentation
o.wrap = false -- Disables line wrapping horizontally
o.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Specifies the undo history
o.undofile = true -- Enables persistent undo history even after closing nvim
o.hlsearch = true -- Disables highlightning of search results
o.incsearch = true -- Enables incremental search which highlights matches as you type
o.termguicolors = true -- The good color
o.scrolloff = 15 -- Keeps at least 8 lines of context above and below the cursor when jumping
o.signcolumn = "yes" -- Always shows the sign column to the left of the line numbers
o.sidescrolloff = 20 -- Keep 8 columns of context to the left and right of the cursor
o.swapfile = false
o.colorcolumn = "80"
o.cmdheight = 0

o.foldenable = false -- Disable folding
o.foldlevel = 1000000
o.foldmethod = "indent"
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

o.tabline = "%t"
vim.g.tabline_separator = " "
vim.opt.showtabline = 2
vim.api.nvim_set_hl(0, "TablineActive", { fg = "#ffffff", bg = "#4a4a4a", bold = true })
vim.api.nvim_set_hl(0, "TablineActiveNumber", { fg = "#7aa2f7", bg = "#4a4a4a", bold = true })

o.fillchars = "diff: " -- Set diff colors to blend with the background; Set the diff separator to use spaces instead of "-"
o.smartindent = true
o.completeopt = { "menuone", "popup", "noinsert" }
o.undodir = vim.fn.stdpath("data") .. "/undodir"
o.undofile = true
o.undolevels = 1000
o.updatetime = 50 -- Faster completion
-- vim.o.textwidth = 80

vim.diagnostic.config({
	-- virtual_lines = {
	-- 	-- current_line = true,
	-- 	format = function(diagnostic)
	-- 		local source = diagnostic.source and ("[" .. diagnostic.source .. "] ") or ""
	-- 		return string.format("%s%s", source, diagnostic.message)
	-- 	end,
	-- },
	virtual_text = {
		current_line = true,
		spacing = 2,
		-- source = "if_many", -- Shows source when multiple servers provide diagnostics
		-- prefix = "", -- You can change this to any symbol you prefer
		format = function(diagnostic)
			local source = diagnostic.source and ("[" .. diagnostic.source .. "] ") or ""
			return string.format("%s%s", source, diagnostic.message)
		end,
	},
	underline = true,
})

o.numberwidth = 2
o.signcolumn = "yes:1"
o.statuscolumn = "%l%s"

vim.opt.synmaxcol = 6000 -- default is 3000

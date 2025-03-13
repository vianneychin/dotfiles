local o = vim.opt

o.nu = true -- Enable line numbers
o.relativenumber = true -- Enable relative line numbering from cursor position
o.cursorline = true
o.tabstop = 4 --  Number of spaces per tab character
o.softtabstop = 4 --  Number of spaces to use when pressing the <Tab> key
o.shiftwidth = 4 -- Number of spaces for auto indentation
o.expandtab = true -- Converts tab to spaces
o.autoindent = true
o.smartindent = true -- Smart indentation
o.wrap = false -- Disables line wrapping horizontally
o.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Specifies the undo history
o.undofile = true -- Enables persistent undo history even after closing nvim
o.hlsearch = true -- Disables highlightning of search results
o.incsearch = true -- Enables incremental search which highlights matches as you type
o.termguicolors = true -- The good color
o.scrolloff = 8 -- Keeps at least 8 lines of context above and below the cursor when jumping
o.signcolumn = "yes" -- Always shows the sign column to the left of the line numbers
o.swapfile = false
o.colorcolumn = "80"
-- o.foldenable = false
-- o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- o.foldtext = ""
-- o.foldlevel = 99
-- o.foldmethod = "expr"
-- o.foldnestmax = 1
o.cmdheight = 1

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

-- Squiggly
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.diagnostic.config({ virtual_lines = false, virtual_text = true, underline = true })
vim.diagnostic.set = (function(orig)
	return function(namespace, bufnr, diagnostics, opts)
		for _, v in ipairs(diagnostics) do
			v.col = v.col or 0
		end
		return orig(namespace, bufnr, diagnostics, opts)
	end
end)(vim.diagnostic.set)

o.numberwidth = 2
o.signcolumn = "yes:1"
o.statuscolumn = "%l%s"

-- -- Enable spell check
-- o.spell = true
-- o.spelllang = { "en_us" }

vim.opt.synmaxcol = 6000 -- default is 3000

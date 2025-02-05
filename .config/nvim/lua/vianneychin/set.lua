vim.opt.nu = true -- Enable line numbers
vim.opt.relativenumber = true -- Enable relative line numbering from cursor position
vim.opt.cursorline = true

vim.opt.tabstop = 4 --  Number of spaces per tab character
vim.opt.softtabstop = 4 --  Number of spaces to use when pressing the <Tab> key
vim.opt.shiftwidth = 4 -- Number of spaces for auto indentation
vim.opt.expandtab = true -- Converts tab to spaces

vim.opt.autoindent = true
vim.opt.smartindent = true -- Smart indentation
vim.opt.wrap = false -- Disables line wrapping horizontally

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Specifies the undo history
vim.opt.undofile = true -- Enables persistent undo history even after closing nvim

vim.opt.hlsearch = true -- Disables highlightning of search results
vim.opt.incsearch = true -- Enables incremental search which highlights matches as you type

vim.opt.termguicolors = true -- The good color

vim.opt.scrolloff = 8 -- Keeps at least 8 lines of context above and below the cursor when jumping
vim.opt.signcolumn = "yes" -- Always shows the sign column to the left of the line numbers

-- vim.opt.updatetime = 50 -- Delay in milliseconds for Neovim to save the swap file
vim.o.swapfile = false

vim.opt.colorcolumn = "80"
-- vim.o.textwidth = 80

-- UFO folding
vim.o.foldenable = true
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

vim.o.cmdheight = 1

vim.o.tabline = "%t"

-- Set diff colors to blend with the background
-- Set the diff separator to use spaces instead of "-"
vim.o.fillchars = vim.o.fillchars .. ",diff: "

-- Allow "rachartieratiny-inline-diagnostic.nvim" to handle
-- diagnostics
vim.diagnostic.config({ virtual_lines = true })
vim.diagnostic.set = (function(orig)
	return function(namespace, bufnr, diagnostics, opts)
		for _, v in ipairs(diagnostics) do
			v.col = v.col or 0
		end
		return orig(namespace, bufnr, diagnostics, opts)
	end
end)(vim.diagnostic.set)
vim.opt.smartindent = true

vim.opt.completeopt = { "menuone", "popup", "noinsert" }

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("vianneychin.remap")
require("vianneychin.set")
require("vianneychin.lazy_init")
require("vianneychin.autocmds")

vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
vim.cmd([[hi DiagnosticUnderlineWarn cterm=undercurl gui=undercurl]])
vim.cmd([[hi DiagnosticUnderlineError cterm=undercurl gui=undercurl]])
vim.cmd([[hi DiagnosticInfo cterm=undercurl gui=undercurl]])


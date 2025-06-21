-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

require("vianneychin.remap")
require("vianneychin.set")
require("vianneychin.lazy_init")
require("vianneychin.autocmds")

vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { undercurl = true })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { undercurl = true })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { undercurl = true })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { undercurl = true })

vim.cmd("colorscheme kanagawa")


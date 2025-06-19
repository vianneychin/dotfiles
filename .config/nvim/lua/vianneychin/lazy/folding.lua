return {
	"kevinhwang91/nvim-ufo",
	dependencies = "kevinhwang91/promise-async",
	event = "VeryLazy",
	opts = {
		open_fold_hl_timeout = 400,
		preview = {
			win_config = {
				border = { "", "─", "", "", "", "─", "", "" },
				winblend = 0,
			},
			mappings = {
				scrollU = "<C-u>",
				scrollD = "<C-d>",
				jumpTop = "[",
				jumpBot = "]",
			},
		},
	},
	config = function(_, opts)
		local handler = function(virtText, lnum, endLnum, width, truncate)
			local newVirtText = {}
			local totalLines = vim.api.nvim_buf_line_count(0)
			local foldedLines = endLnum - lnum
			local suffix = ("   %d lines truncated  |  %d%% of file hidden"):format(foldedLines, foldedLines / totalLines * 100)
			local sufWidth = vim.fn.strdisplaywidth(suffix)
			local targetWidth = width - sufWidth
			local curWidth = 0
			for _, chunk in ipairs(virtText) do
				local chunkText = chunk[1]
				local chunkWidth = vim.fn.strdisplaywidth(chunkText)
				if targetWidth > curWidth + chunkWidth then
					table.insert(newVirtText, chunk)
				else
					chunkText = truncate(chunkText, targetWidth - curWidth)
					local hlGroup = chunk[2]
					table.insert(newVirtText, { chunkText, hlGroup })
					chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if curWidth + chunkWidth < targetWidth then
						suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
					end
					break
				end
				curWidth = curWidth + chunkWidth
			end
			local rAlignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
			suffix = (" "):rep(rAlignAppndx) .. suffix
			table.insert(newVirtText, { suffix, "MoreMsg" })
			return newVirtText
		end
		opts["fold_virt_text_handler"] = handler
		require("ufo").setup(opts)
		vim.api.nvim_set_hl(0, "Folded", {
			bg = "#1e1e2e",
			blend = 30,  -- Values from 0-100, higher is more transparent
			fg = "#89b4fa",
			italic = true,
		})

		vim.fn.sign_define("FoldClosed", { text = "▸", texthl = "Folded" })
		vim.fn.sign_define("FoldOpen", { text = "▾", texthl = "Folded" })
		vim.fn.sign_define("FoldSeparator", { text = " ", texthl = "Folded" })
	end,
}

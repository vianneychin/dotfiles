local function extract_filenames(items)
	local out = {}
	for i, v in ipairs(items) do
		out[i] = v.value
	end
	return out
end

local function reduce_path(f)
	local filename = f:match("([^/\\]+)$") or f
	-- Get the icon and the highlight group for this file.
	local icon, hl = require("mini.icons").get("file", filename)
	-- If an icon was returned, wrap it using statusline highlight syntax.
	local icon_str = ""
	if icon then
		icon_str = "%#" .. hl .. "#" .. icon .. "%* " -- Result: %#HLGroup#icon%*
	end
	return icon_str .. filename
end

local function remove_and_compact_and_select_next_item()
	local harpoon = require("harpoon")
	local list = harpoon:list()
	local original_length = list:length()
	-- Get current index before removal
	local current = list:get()
	local current_idx = current and current.index or 1
	-- Remove the current item
	list:remove()
	-- Compact the list by creating a new temporary list
	local temp_items = {}
	local new_idx = 1
	for i = 1, original_length do
		local item = list:get(i)
		if item ~= nil then
			temp_items[new_idx] = item
			new_idx = new_idx + 1
		end
	end
	-- Clear and rebuild the list
	list:clear()
	for i, item in ipairs(temp_items) do
		list:replace_at(i, item)
	end
	-- Select the same position or the last item if we were at the end
	local new_length = list:length()
	if new_length > 0 then
		if current_idx > new_length then
			list:select(new_length)
		else
			list:select(current_idx)
		end
	end
	vim.cmd.redrawtabline()
end

return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { { "nvim-lua/plenary.nvim" }, { "echasnovski/mini.nvim" } },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup({})
			vim.keymap.set("n", "<leader>A", function()
				harpoon:list():prepend()
				vim.cmd.redrawtabline()
			end)
			vim.keymap.set("n", "<leader>a", function()
				harpoon:list():add()
				vim.cmd.redrawtabline()
			end)
			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)
			vim.keymap.set("n", "<leader>d", function()
				remove_and_compact_and_select_next_item()
				vim.cmd.redrawtabline()
			end)
			for i = 1, 9 do
				vim.keymap.set("n", "<leader>" .. i, function()
					harpoon:list():select(i)
				end)
			end
			if not vim.g.tabline_tree_offset then
				vim.g.tabline_tree_offset = 0
			end
			function tabline()
				local s = ""
				local fill_amount = vim.g.tabline_tree_offset
				if vim.g.tabline_separator then
					fill_amount = fill_amount - 1
					if fill_amount < 0 then
						fill_amount = 0
					end
				end
				for i = 0, fill_amount do
					s = s .. " "
				end
				if vim.g.tabline_separator then
					s = s .. vim.g.tabline_separator
				end
				local marked_files = extract_filenames(harpoon:list().items)
				local cwd = vim.fn.getcwd()
				local current_file = vim.api.nvim_buf_get_name(0):gsub("^" .. cwd .. "/", "")
				local max_length = (vim.api.nvim_win_get_width(0) - (5 * 9)) / 9 -- adjusted for 9 tabs
				for i, f in ipairs(marked_files) do
					if i > 9 then
						break
					end
					local display_path = reduce_path(f)
					local entry = {}
					-- Customize tab text color
					local highlight = f == current_file and "%#HarpoonHighlight#" or "%#TablineInactive#"
					table.insert(
						entry,
						string.format(
							"%s %d %s %%#TablineInactive#%s",
							highlight,
							i,
							display_path,
							vim.g.tabline_separator
						)
					)
					s = s .. table.concat(entry)
				end
				s = s .. "%#TablineEnd#"
				return s
			end
			vim.go.tabline = "%!v:lua.tabline()"

			-- Define custom highlight groups
			vim.api.nvim_set_hl(0, "HarpoonHighlight", { fg = "#fab387" })
			vim.api.nvim_set_hl(0, "TablineInactive", { fg = "#45475a" })
		end,
	},
}

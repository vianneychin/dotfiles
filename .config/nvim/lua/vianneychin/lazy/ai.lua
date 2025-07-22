local SYSTEM_PROMPT = [[<role>
Senior Software Engineer at a top web development agency with expertise in Laravel, PHP, MySQL, TypeScript, and React.
</role>

<context>
User's stack: Laravel, PHP, MySQL, TypeScript, React
Operating System: %s (use OS-specific commands)
</context>

<instructions>
- Keep responses short and technical
- Focus on the code changes requested
- Skip pleasantries and basic explanations
- Consider performance, security, and Laravel/React best practices
</instructions>

<code_format>
For each file change:
1. Header: ### [file:filename.php](path/to/file.php) • Lines: 45-52
2. Brief explanation of the change
3. Code block with:
   - Triple backticks and language identifier
   - For PHP: Always start with <?php tag to ensure syntax highlighting and readability
   - Complete code for the line range
   - Original indentation preserved
   - No line numbers or truncation

Response structure:
- Issue summary (1-2 sentences max)
- Code modifications
- Critical notes only if needed (migrations, breaking changes)
</code_format>

<example>
### [file:UserController.php](app/Http/Controllers/UserController.php) • Lines: 45-52

Fixing N+1 query problem:

```php
<?php
public function index(Request $request)
{
    $users = User::with(['posts', 'comments'])
        ->when($request->search, function ($query, $search) {
            return $query->where('name', 'like', "%{$search}%");
        })
        ->paginate(15);

    return response()->json($users);
}
</example>]]
return {
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({
				ignore_filetypes = { ["codecompanion"] = true },
			})
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		opts = {},
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
			{ "nvim-lua/plenary.nvim" },
			{ "saghen/blink.cmp", lazy = false, version = "*" },
		},
		config = function()
			local opts = {
				opts = {
					system_prompt = function(opts)
						-- replace system prompt with empty one, check if it works
						return SYSTEM_PROMPT
					end,
				},

				adapters = {
					anthropic = function()
						local get_anthropic_api_key = function()
							local file_path = os.getenv("HOME") .. "/anthropic/key.txt"
							local f = io.open(file_path, "rb")
							if not f then
								print("Failed to open Anthropic API key file")
								return ""
							end

							local content = f:read("*a")
							f:close()

							local api_key = string.gsub(content, "%s+", "")
							return api_key
						end
						return require("codecompanion.adapters").extend("anthropic", {
							env = {
								api_key = get_anthropic_api_key(),
							},
						})
					end,
				},

				strategies = {
					chat = {

						variables = {
							["buffer"] = {
								opts = {
									default_params = "watch",
								},
							},
						},
						slash_commands = {
							["file"] = {
								keymaps = {
									modes = {
										i = "<C-b>",
										n = { "<leader>p", "gb" },
									},
								},
								opts = {
									provider = "snacks",
								},
							},
						},
						adapter = "anthropic",
						keymaps = {
							send = {
								modes = { n = "<C-s>", i = "<C-s>" },
							},
							clear = {
								modes = {
									n = "<C-l>",
								},
								description = "Clear the chat buffer",
							},
							close = {
								modes = {
									n = "<leader>q",
									i = "<C-w>q",
								},
							},
						},
					},
				},
			}

			local codecompanion_group = vim.api.nvim_create_augroup("CodeCompanionAutoSave", { clear = true })
			-- Timer for debouncing saves
			local save_timer = nil
			local SAVE_DELAY_MS = 2000 -- 2 second delay

			local function save_codecompanion_buffer(bufnr)
				local save_dir = vim.fn.expand("~/.local/share/nvim/codecompanion/")
				if not vim.api.nvim_buf_is_valid(bufnr) then
					return
				end

				local bufname = vim.api.nvim_buf_get_name(bufnr)

				-- Extract the unique ID from the buffer name
				local id = nil
				if vim.bo.filetype == "codecompanion" then
					id = bufname:match("%[CodeCompanion%] (%d+)")
				end
				local date = os.date("%Y-%m-%d")
				local save_path

				if id then
					-- Use date plus ID to ensure uniqueness
					save_path = save_dir .. date .. "_codecompanion_" .. id .. ".md"
				else
					-- Fallback with timestamp to ensure uniqueness if no ID
					save_path = save_dir .. date .. "_codecompanion_" .. os.date("%H%M%S") .. ".md"
				end

				-- Create directory if it doesn't exist
				vim.fn.mkdir(save_dir, "p")

				-- Write buffer content to file
				local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
				local file = io.open(save_path, "w")
				if file then
					file:write(table.concat(lines, "\n"))
					file:close()
				end
			end

			local function debounced_save(bufnr)
				-- Cancel existing timer if itkkkk exists
				if save_timer then
					save_timer:stop()
					save_timer:close()
				end

				-- Create new timerkkk
				save_timer = vim.loop.new_timer()
				save_timer:start(
					SAVE_DELAY_MS,
					0,
					vim.schedule_wrap(function()
						save_codecompanion_buffer(bufnr)
						save_timer:close()
						save_timer = nil
					end)
				)
			end

			local function load_codecompanion_conversations()
				local save_dir = vim.fn.expand("~/.local/share/nvim/codecompanion/")

				-- Find all codecompanion markdown files
				local pattern = save_dir .. "*_codecompanion_*.md"
				local files = vim.fn.glob(pattern, false, true)

				if #files == 0 then
					vim.notify("No saved CodeCompanion conversations found", vim.log.levels.INFO)
					return
				end

				-- Sort files by modification time (newest first)
				table.sort(files, function(a, b)
					return vim.fn.getftime(a) > vim.fn.getftime(b)
				end)

				-- Create quickfix entries
				local qf_entries = {}
				for _, file in ipairs(files) do
					local basename = vim.fn.fnamemodify(file, ":t:r") -- filename without extension
					local date_part = basename:match("(%d%d%d%d%-%d%d%-%d%d)")
					local id_part = basename:match("codecompanion_(%w+)")

					local text = string.format("CodeCompanion %s (%s)", date_part or "Unknown", id_part or "Unknown")

					table.insert(qf_entries, {
						filename = file,
						text = text,
						lnum = 1,
						col = 1,
					})
				end

				-- Populate quickfix list
				vim.fn.setqflist(qf_entries, "r")
				vim.cmd("copen")
				vim.notify(string.format("Loaded %d CodeCompanion conversations", #qf_entries), vim.log.levels.INFO)
			end

			-- Save converstaion history on insert/change/leave
			vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "BufLeave", "FocusLost" }, {
				group = codecompanion_group,
				callback = function(args)
					local bufnr = args.buf
					local bufname = vim.api.nvim_buf_get_name(bufnr)

					if bufname:match("%[CodeCompanion%]") then
						-- Use immediate save for BufLeave and FocusLost to ensure data isn't lost
						if args.event == "BufLeave" or args.event == "FocusLost" then
							save_codecompanion_buffer(bufnr)
						else
							debounced_save(bufnr)
						end
					end
				end,
			})

			-- -- Add a command to easily access this function
			vim.api.nvim_create_user_command("CodeCompanionHistory", load_codecompanion_conversations, {
				desc = "Load previous CodeCompanion conversations into quickfix list",
			})

			-- vim.api.nvim_create_autocmd("User", {
			-- 	pattern = "CodeCompanionChatCreated",
			-- 	callback = function(event)
			-- 		local chat = require("codecompanion").buf_get_chat(event.data.bufnr)
			-- 		if chat then
			-- 			local current_buf = vim.api.nvim_get_current_buf()
			--
			-- 			-- Check if we're in a codecompanion buffer
			-- 			if vim.bo[current_buf].filetype == "codecompanion" then
			-- 				-- Get the previous buffer (alternate buffer)
			-- 				local prev_buf = vim.fn.bufnr("#")
			--
			-- 				-- Ensure it's a valid buffer and not another codecompanion buffer
			-- 				if
			-- 					prev_buf ~= -1
			-- 					and vim.api.nvim_buf_is_valid(prev_buf)
			-- 					and vim.bo[prev_buf].filetype ~= "codecompanion"
			-- 				then
			-- 					chat:add_message({
			-- 						role = "user",
			-- 						content = "#buffer:" .. prev_buf .. ":watch",
			-- 					}, { reference = true })
			-- 				end
			-- 			end
			-- 		end
			-- 	end,
			-- })

			-- Auto-add #buffer to codecompanion buffers if not present
			-- This will add the current buffer as context to the chat
			vim.api.nvim_create_autocmd("User", {
				pattern = "CodeCompanionChatCreated",
				callback = function(event)
					local chat = require("codecompanion").buf_get_chat(event.data.bufnr)
					if chat then
						-- Insert #buffer at the end of the chat buffer
						local line_count = vim.api.nvim_buf_line_count(event.data.bufnr)
						vim.api.nvim_buf_set_lines(
							event.data.bufnr,
							line_count,
							line_count,
							false,
							{ "", "#buffer", "" }
						)
					end
				end,
			})

			require("codecompanion").setup(opts)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>cc",
				"<cmd>CodeCompanionChat Toggle<cr>",
				{ noremap = true, silent = true }
			)
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "codecompanion" },
	},
	{
		"HakonHarnes/img-clip.nvim",
		opts = {
			filetypes = {
				codecompanion = {
					prompt_for_file_name = false,
					template = "[Image]($FILE_PATH)",
					use_absolute_path = true,
				},
			},
		},
	},
}

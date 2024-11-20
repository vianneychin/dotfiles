return { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { -- If encountering errors, see telescope-fzf-native README for installation instructions
            'nvim-telescope/telescope-fzf-native.nvim',

            -- `build` is used to run some command when the plugin is installed/updated.
            -- This is only run then, not every time Neovim starts up.
            build = 'make',

            -- `cond` is a condition used to determine whether this plugin should be
            -- installed and loaded.
            cond = function()
                return vim.fn.executable 'make' == 1 end,
        },
        -- Useful for getting pretty icons, but requires a Nerd Font.
        { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    keys = {
        {
            "<leader>F",
            function()
                require("telescope.builtin").live_grep()
            end
        }
    },
    config = function()
        require('telescope').setup {
            file_ignore_patterns = { "%.git/.", "%public/vendor/horizon/." },
            -- You can put your default mappings / updates / etc. in here
            --  All the info you're looking for is in `:help telescope.setup()`
            defaults = {
                path_display = {
                    "filename_first",
                },
                results_title = false,
                prompt_title = false,
                sorting_strategy = "ascending",
                select_strategy = "reset",
                set_env = { ["COLORTERM"] = "truecolor" },
                layout_config = {
                    preview_cutoff = 120,
                    prompt_position = "top"
                },
                mappings = {},
                preview = {
                    treesitter = false
                }
            },
            pickers = {
                find_files = {
                    previewer = false,
                    layout_config = {
                        height = 0.4,
                        prompt_position = 'top',
                        preview_cutoff = 120
                    }
                },
                live_grep = {
                    only_sort_text = true,
                }
            },
            -- pickers = {}
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = 'smart_case'
                },
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown({
                        sorting_strategy = "ascending",
                        layout_config = {
                            width = 0.5,
                            height = 0.4,
                            preview_width = 0.6
                        }
                    }),
                },
            },
        }

        -- Enable Telescope extensions if they are installed
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')

        -- See `:help telescope.builtin`
        local builtin = require 'telescope.builtin'

        vim.keymap.set('n', '<leader>p', function()
            require('telescope.builtin').find_files({ hidden = true })
        end, { desc = '[S]earch [F]iles' })


        vim.keymap.set('n', '<leader>so', builtin.lsp_document_symbols, { desc = '[S]earch Symb[o]ls / Functions' })
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>ks', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        -- vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

        -- Slightly advanced example of overriding default behavior and theme
        vim.keymap.set('n', '<leader>/', function()
            -- You can pass additional configuration to Telescope to change the theme, layout, etc.
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = '[/] Fuzzily search in current buffer' })

        -- It's also possible to pass additional configuration options.
        --  See `:help telescope.builtin.live_grep()` for information about particular keys
        vim.keymap.set('n', '<leader>s/', function()
            builtin.live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
            }
        end, { desc = '[S]earch [/] in Open Files' })

        -- Shortcut for searching your Neovim configuration files
        vim.keymap.set('n', '<leader>sn', function()
            builtin.find_files { cwd = vim.fn.stdpath 'config' }
        end, { desc = '[S]earch [N]eovim files' })
    end,
}

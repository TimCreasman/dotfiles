return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            --[[ local state = require('telescope.state')
            local last_search = nil

            -- remember the last thing searched for:
            local function search_with_cache()
                if last_search == nil then
                    builtin.live_grep()

                    local cached_pickers = state.get_global_key "cached_pickers" or {}
                    last_search = cached_pickers[1]
                else
                    builtin.resume({ picker = last_search })
                end
            end ]]

            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

            -- live grep with visual selection
            local get_selection = function()
                return vim.fn.getregion(
                    vim.fn.getpos ".", vim.fn.getpos "v", { mode = vim.fn.mode() }
                )
            end
            vim.keymap.set("v", "<leader>fg", function()
                builtin.live_grep {
                    default_text = table.concat(get_selection())
                }
            end
            )

            -- TODO should this be moved to lsp?
            -- if gd goes to the same location as the cursor, automatically call lsp_references
            local goto_definition_or_reference = function()
                local function on_list(options)
                    local cursorPos = vim.fn.getpos(".")
                    local bufnr = vim.api.nvim_win_get_buf(0)
                    local defPos = { options.items[1].lnum, options.items[1].col }
                    local defBufnr = options.context.bufnr
                    if bufnr == defBufnr and cursorPos[2] == defPos[1] and cursorPos[3] == defPos[2] then
                        builtin.lsp_references()
                    else
                        vim.fn.setqflist({}, ' ', options)
                        vim.cmd.cfirst()
                    end
                end

                vim.lsp.buf.definition({ on_list = on_list })
            end

            vim.keymap.set("n", "gd", goto_definition_or_reference, {})

            vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
            vim.keymap.set({ "n", "v" }, "<leader>fr", builtin.lsp_references, {})
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}

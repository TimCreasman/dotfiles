return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require("telescope.builtin")
            local state = require('telescope.state')
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
            end

            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", search_with_cache, {})
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

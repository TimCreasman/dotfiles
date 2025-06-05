return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    lazy = false,
    config = function()
        require("neo-tree").setup({
            source_selector = {
                winbar = true,
            },
            filesystem = {
                filtered_items = {
                    visible = true,
                },
                follow_current_file = {
                    enabled = true,
                },
                use_libuv_file_watcher = true,
            },
            window = {
                mappings = {
                    ['e'] = function() vim.api.nvim_exec('Neotree focus filesystem left', true) end,
                    ['b'] = function() vim.api.nvim_exec('Neotree focus buffers left', true) end,
                    ['g'] = function() vim.api.nvim_exec('Neotree focus git_status left', true) end,
                }
            }
        })
        vim.keymap.set("n", "<leader>n", ":Neotree toggle<CR>", { desc = "Toggle the filesystem browser" })

        -- auto open neo tree
        vim.api.nvim_create_augroup("neotree", {})
        vim.api.nvim_create_autocmd("UiEnter", {
            desc = "Open Neotree automatically",
            group = "neotree",
            callback = function()
                if vim.fn.argc() == 0 then
                    vim.cmd("Neotree action=show")
                end
            end,
        })
    end,
}

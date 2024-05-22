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
            filesystem = {
                filtered_items = {
                    visible = true,
                },
                follow_current_file = {
                    enabled = true,
                }
            },
        })
        vim.keymap.set("n", "<leader>n", ":Neotree toggle<CR>", {})

        -- auto open neo tree
        -- vim.api.nvim_create_augroup("neotree", {})
        -- vim.api.nvim_create_autocmd("UiEnter", {
        --     desc = "Open Neotree automatically",
        --     group = "neotree",
        --     callback = function()
        --         if vim.fn.argc() == 0 then
        --             vim.cmd("Neotree toggle")
        --         end
        --     end,
        -- })
    end,
}

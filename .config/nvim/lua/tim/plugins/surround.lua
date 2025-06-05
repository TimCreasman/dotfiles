return {
    "kylechui/nvim-surround",
    version = "^3.0.0",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            keymaps = {
                insert = "<C-g>s",
                insert_line = "<C-g>S",
                normal = "<leader>s",
                normal_cur = "<leader>ssy",
                normal_line = "<leader>Sy",
                normal_cur_line = "<leader>SSy",
                visual = "<leader>S",
                visual_line = "<leader>Sg",
                delete = "<leader>sd",
                change = "<leader>sc",
                change_line = "<leader>Sc",
            },
        })
    end
}

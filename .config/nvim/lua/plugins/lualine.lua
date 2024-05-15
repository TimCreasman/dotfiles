return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                theme = "solarized_dark",
            },
            sections = { lualine_c = { require('auto-session.lib').current_session_name } }
        })
    end,
}

return {
    -- Figure this out eventually. See:
    -- https://www.johntobin.ie/blog/debugging_in_neovim_with_nvim-dap/
    --[[ {
        "mfussenegger/nvim-dap",
        lazy = true,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "mfussenegger/nvim-dap",
            "williamboman/mason.nvim", -- This must be setup first
        },
        config = function()
            local debug_servers = require("tim.configs.dap")
            require("mason-nvim-dap").setup({
                handlers = {},
                automatic_installation = true,
                ensure_installed = debug_servers
            })
        end
    }, ]]
}

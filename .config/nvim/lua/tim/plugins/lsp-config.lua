return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
        config = function()
            local servers = require("tim.configs.lsp")
            require("mason-lspconfig").setup({
                automatic_enable = false,
                ensure_installed = servers,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "saecki/live-rename.nvim" },
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "LspInfo", "LspInstall", "LspUninstall" },
        config = function()
            local lspconfig = require("lspconfig")

            -- Default config to apply to all lsps
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local global_lsp_config = {
                capabilities = capabilities
            }

            local servers = require("tim.configs.lsp")

            for _, server_name in pairs(servers) do
                local lsp_config = lspconfig[server_name]
                if lsp_config == nil then
                    error("lsp not found for " .. server_name)
                    break
                end

                local has_custom_config, custom_lsp_config = pcall(require, "tim.configs.lsp." .. server_name)

                if not has_custom_config then
                    custom_lsp_config = {}
                end

                lsp_config = vim.tbl_deep_extend(
                    "force",
                    lsp_config,
                    custom_lsp_config,
                    global_lsp_config
                )
                vim.lsp.enable(server_name)
                vim.lsp.config(server_name, lsp_config)
            end

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }

                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "K", function()
                        vim.lsp.buf.hover { border = "single", max_height = 25, max_width = 120 }
                    end, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                    local live_rename = require("live-rename")
                    vim.keymap.set({ "n", "v" }, "<leader>rn", live_rename.map({ text = "", insert = true }),
                        { desc = "LSP rename" })

                    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
                end,
            })
        end,
    },
}

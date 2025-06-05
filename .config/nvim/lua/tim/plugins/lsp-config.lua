return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                    "eslint@4.8.0",
                    "angularls",
                    "html",
                    "emmet_ls",
                    "cssls",
                    "tailwindcss",
                    "gopls"
                },
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
            local config = {
                capabilities = capabilities
            }

            local servers = require("tim.configs.lsps")

            for _, server_name in pairs(servers) do
                local server = lspconfig[server_name]
                if server == nil then
                    error("lsp not found for " .. server_name)
                    break
                end

                local has_custom_config, custom_config = pcall(require, "tim.configs.lsps." .. server_name)

                if has_custom_config then
                    config = vim.tbl_deep_extend(
                        "force",
                        custom_config,
                        config
                    )
                end
                server.setup(config)
            end

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }

                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
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

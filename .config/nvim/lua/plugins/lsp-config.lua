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
                ensure_installed = { "lua_ls", "tsserver", "eslint@4.8.0", "angularls", "html", "emmet_language_server" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local lspconfig = require("lspconfig")

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })

            lspconfig.tsserver.setup({
                capabilities = capabilities,
            })

            lspconfig.eslint.setup({
                capabilities = capabilities,
                settings = {
                    packageManager = "npm",
                },
                on_attach = function(_, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        command = "EslintFixAll",
                    })
                end,
            })


            lspconfig.html.setup({
                capabilities = capabilities,
                filetypes = { "html", "angular.html" }
            })

            lspconfig.emmet_language_server.setup({
                capabilities = capabilities,
                filetypes = { "html", "angular.html" }
            })

            local project_library_path = "/Users/tcreasman/.npm-global/lib/node_modules"

            local cmd = {
                "/Users/tcreasman/.npm-global/lib/node_modules/@angular/language-server/bin/ngserver",
                "--ngProbeLocations",
                project_library_path,
                "--tsProbeLocations",
                project_library_path,
                "--stdio",
            }

            lspconfig.angularls.setup({
                cmd = cmd,
                on_new_config = function(new_config, new_root_dir)
                    new_config.cmd = cmd
                end,
                filetypes = { "html", "angular.html", "typescript", "typescriptreact", "typescript.tsx" }
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }

                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                    vim.keymap.set({ "n", "v" }, "<leader>rn", vim.lsp.buf.rename, opts)

                    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
                end,
            })
        end,
    },
}

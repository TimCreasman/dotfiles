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
                    "tsserver",
                    "eslint@4.8.0",
                    "angularls",
                    "html",
                    "emmet_language_server",
                    "cssls",
                },
                ensure_installed = { "lua_ls", "tsserver", "eslint", "angularls", "html", "emmet_language_server" },
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

            -- Typescript lsps
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

            -- HTML lsps
            lspconfig.html.setup({
                capabilities = capabilities,
                filetypes = { "html", "angular.html" }
            })

            lspconfig.emmet_language_server.setup({
                capabilities = capabilities,
                filetypes = { "html", "angular.html" }
            })

            lspconfig.cssls.setup({
                capabilities = capabilities
            })

            -- Note: this is mainly a workaround as this relies on a global angular lsp to be installed 
            -- If this fails, ensure @angular/language-server, @angular/language-service and typescript are all installed globally
            local npm_global_path = vim.fn.system("npm config get prefix"):gsub("\n", "") -- remove newlines
            local project_library_path = npm_global_path .. "/lib/node_modules"
            local cmd = {
                npm_global_path .. "/lib/node_modules/@angular/language-server/bin/ngserver",
                "--ngProbeLocations",
                project_library_path,
                "--tsProbeLocations",
                project_library_path,
                "--stdio",
            }

            lspconfig.angularls.setup({
                cmd = cmd,
                on_new_config = function(new_config, _)
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

return {
    {
        dir = "~/projects/neo-tree-tests-source.nvim",
    },
    {
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
                sources = {
                    "filesystem",
                    "buffers",
                    "git_status",
                    "tests"
                },
                source_selector = {
                    winbar = true,
                },
                filesystem = {
                    bind_to_cwd = true,
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
                        ['e'] = function() vim.api.nvim_exec2('Neotree focus filesystem left', { output = true }) end,
                        ['b'] = function() vim.api.nvim_exec2('Neotree focus buffers left', { output = true }) end,
                        ['g'] = function() vim.api.nvim_exec2('Neotree focus git_status left', { output = true }) end,
                        ['t'] = function() vim.api.nvim_exec2('Neotree focus tests left', { output = true }) end,
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
    } }

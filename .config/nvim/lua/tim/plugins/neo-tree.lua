return {
    {
        dir = "~/projects/neo-tree-tests",
        -- config = function()
        --     require("neo-tree-tests").setup()
        -- end
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            -- "~/projects/neo-tree-tests"
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
                    filtered_items = {
                        visible = true,
                    },
                    follow_current_file = {
                        enabled = true,
                    },
                    use_libuv_file_watcher = true,
                },
                tests = {
                    -- The config for your source goes here. This is the same as any other source, plus whatever
                    -- special config options you add.
                    --window = {...}
                    --renderers = { ..}
                    --etc
                },
                window = {
                    mappings = {
                        ['e'] = function() vim.api.nvim_exec('Neotree focus filesystem left', true) end,
                        ['b'] = function() vim.api.nvim_exec('Neotree focus buffers left', true) end,
                        ['g'] = function() vim.api.nvim_exec('Neotree focus git_status left', true) end,
                        ['x'] = function() vim.api.nvim_exec('Neotree focus tests left', true) end,
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

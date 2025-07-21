return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            "TimCreasman/neo-tree-tests-source.nvim"
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
                    sources = {
                        { source = "filesystem" },
                        { source = "buffers" },
                        { source = "git_status" },
                        { source = "tests" },
                    },
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
                tests = {
                    window = {
                        mappings = {
                            ['p'] = "run_tests"
                        }
                    }
                },
                window = {
                    mappings = {
                        ['E'] = function() vim.api.nvim_exec2('Neotree focus filesystem left', { output = true }) end,
                        ['b'] = function() vim.api.nvim_exec2('Neotree focus buffers left', { output = true }) end,
                        ['g'] = function() vim.api.nvim_exec2('Neotree focus git_status left', { output = true }) end,
                        ['t'] = function() vim.api.nvim_exec2('Neotree focus tests right', { output = true }) end,
                        -- ['Z'] = "expand_all_subnodes"
                    }
                }
            })
            vim.keymap.set("n", "<leader>n", ":Neotree toggle<CR>", { desc = "Toggle the filesystem browser" })

            -- set tree to closest .git project,
            -- TODO I would like this to be an autocmd but that messes with the sessions?
            local utils = require("tim.core.utils")
            local neo_tree_commands = require("neo-tree.sources.filesystem.commands")
            local neo_tree_sources_manager = require("neo-tree.sources.manager")
            local set_to_git = function()
                local target_dir = utils.closest_git_dir()
                if target_dir ~= nil and vim.fn.getcwd() ~= target_dir then
                    vim.cmd('cd ' .. utils.closest_git_dir())

                    -- TODO find a better way to refresh neo tree programatically
                    -- Supposedly the filesystem should be synced with cwd but this isn't the case?
                    neo_tree_commands.refresh(neo_tree_sources_manager.get_state("filesystem"))
                end
            end

            vim.keymap.set("n", "<leader>g", set_to_git, { desc = "Set neo-tree root to .git project" })

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

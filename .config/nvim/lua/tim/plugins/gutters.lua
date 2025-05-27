return {
    {
        "lewis6991/gitsigns.nvim",
        dependencies = {
            "nvim-neo-tree/neo-tree.nvim",
        },
        config = function()
            require("gitsigns").setup {
                on_attach = function(bufnr)
                    local gitsigns = require('gitsigns')

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- refresh neo tree when calling git
                    local function refresh_tree_git(func)
                        return function()
                            local events = require("neo-tree.events")
                            events.fire_event(events.GIT_EVENT)
                            func()
                        end
                    end

                    -- Actions
                    map('n', '<leader>hs', refresh_tree_git(gitsigns.stage_hunk))
                    map('n', '<leader>hr', refresh_tree_git(gitsigns.reset_hunk))

                    map('v', '<leader>hs', function()
                        refresh_tree_git(gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }))
                    end)

                    map('v', '<leader>hr', function()
                        refresh_tree_git(gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }))
                    end)

                    map('n', '<leader>hS', refresh_tree_git(gitsigns.stage_buffer))
                    map('n', '<leader>hR', refresh_tree_git(gitsigns.reset_buffer))
                    map('n', '<leader>hp', gitsigns.preview_hunk)
                    map('n', '<leader>hi', gitsigns.preview_hunk_inline)

                    map('n', '<leader>hb', function()
                        gitsigns.blame_line({ full = true })
                    end)

                    map('n', '<leader>hd', gitsigns.diffthis)

                    map('n', '<leader>hD', function()
                        gitsigns.diffthis('~')
                    end)
                end
            }
        end
    },
    {
        "Isrothy/neominimap.nvim",
        lazy = false,
        init = function()
            vim.g.neominimap = {
                auto_enable = true,
            }
        end,
    },
}

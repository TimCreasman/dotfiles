return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/neotest-go",
            "MisanthropicBit/neotest-busted",
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-neotest/neotest-plenary",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "zidhuss/neotest-minitest",
            "TimCreasman/neo-tree-tests-source.nvim"
        },
        config = function()
            -- get neotest namespace (api call creates or returns namespace)
            local neotest_ns = vim.api.nvim_create_namespace("neotest")
            vim.diagnostic.config({
                virtual_text = {
                    format = function(diagnostic)
                        local message =
                            diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                        return message
                    end,
                },
            }, neotest_ns)
            local neotest = require("neotest")
            neotest.setup({
                -- your neotest config here
                adapters = {
                    require("neotest-plenary"),
                    require("neotest-go"),
                    require("neotest-minitest"),
                    -- require("neotest-busted")({
                    --     local_luarocks_only = false
                    -- }),
                },
                consumers = {
                    neotree = require("neotest.consumers.neotree")
                }
            })

            vim.keymap.set("n", "<leader>tr", neotest.run.run, {})
            vim.keymap.set("n", "<leader>ta", function()
                neotest.run.run(vim.fn.expand("%"))
            end, {})
            vim.keymap.set("n", "<leader>to", neotest.output.open, {})
            vim.keymap.set("n", "<leader>ts", neotest.summary.toggle, {})
        end
    } }

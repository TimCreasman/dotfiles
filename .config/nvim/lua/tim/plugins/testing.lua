return {
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/neotest-go",
            "MisanthropicBit/neotest-busted",
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter"
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
                    require("neotest-go"),
                    require("neotest-busted")({}),
                },
            })

            vim.keymap.set("n", "<leader>tr", neotest.run.run, {})
            vim.keymap.set("n", "<leader>ta", function()
                neotest.run.run(vim.fn.expand("%"))
            end, {})
            vim.keymap.set("n", "<leader>to", neotest.output.open, {})
        end
    } }

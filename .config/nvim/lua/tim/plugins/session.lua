return {
    "stevearc/resession.nvim",
    config = function()
        local resession = require("resession")
        resession.setup()

        -- Configuration pulled from:
        -- https://github.com/stevearc/resession.nvim?tab=readme-ov-file#create-one-session-per-directory
        vim.api.nvim_create_autocmd("VimEnter", {
            callback = function()
                -- Only load the session if nvim was started with no args and without reading from stdin
                if vim.fn.argc(-1) == 0 and not vim.g.using_stdin then
                    -- Save these to a different directory, so our manual sessions don't get polluted
                    resession.load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
                    -- Center screen
                    vim.cmd("norm zz")
                end
            end,
            desc = "Calls resession load on vim enter",
            nested = true,
        })

        vim.api.nvim_create_autocmd("VimLeavePre", {
            callback = function()
                resession.save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
            end,
            desc = "Calls resession save on vim leave",
        })

        vim.api.nvim_create_autocmd('StdinReadPre', {
            callback = function()
                -- Store this for later
                vim.g.using_stdin = true
            end,
            desc = "Do not load session if reading from stdin",
        })
    end
}

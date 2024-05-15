return {
    'rmagatti/auto-session',
    config = function()
        local function openNeotree()
            vim.cmd("Neotree")
            vim.cmd([[<c-w><c-p>]])
        end
        require("auto-session").setup {
            log_level = "error",
            auto_session_suppress_dirs = { "~/", "~/projects", "~/Downloads", "/" },
            pre_save_cmds = { "tabdo Neotree close" },
            post_restore_cmds = { openNeotree }
        }
    end
}

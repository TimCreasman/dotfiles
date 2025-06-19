local utils = require("tim.core.utils")
local neo_tree_commands = require("neo-tree.sources.filesystem.commands")
local neo_tree_sources_manager = require("neo-tree.sources.manager")

vim.api.nvim_create_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup(
        'tim_lsp_format_before_write',
        { clear = true }
    ),
    desc = 'Auto format a file before saving.',
    callback = function(_)
        vim.lsp.buf.format()
    end
})

local workingDir = vim.api.nvim_create_augroup('tim_change_working_dir_on_buf_enter', { clear = true })
-- This help keeps the working directory locked to the directory where .git resides if possible
vim.api.nvim_create_autocmd("VimEnter", {
    group = workingDir,
    callback = function(_)
        -- delay the creation of this autocmd until all startup is completed
        vim.api.nvim_create_autocmd('BufWinEnter', {
            group = vim.api.nvim_create_augroup(
                'tim_change_working_dir_on_buf_enter',
                { clear = true }
            ),
            desc = 'Change the working directory when navigating across projects.',
            callback = function(_)
                local target_dir = utils.closest_git_dir()
                if target_dir ~= nil and vim.fn.getcwd() ~= target_dir then
                    vim.cmd('cd ' .. utils.closest_git_dir())

                    -- TODO find a better way to refresh neo tree programatically
                    -- Supposedly the filesystem should be synced with cwd but this isn't the case?
                    neo_tree_commands.refresh(neo_tree_sources_manager.get_state("filesystem"))
                end
            end
        })
    end
})

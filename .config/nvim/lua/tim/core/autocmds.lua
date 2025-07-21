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

-- TODO build better groups
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    group = vim.api.nvim_create_augroup(
        'tim_center_screen_on_enter',
        { clear = true }
    ),
    desc = "Auto center screen whenever entering a new buffer",
    callback = function(_)
        if vim.bo.buftype == "" then
            -- TOD is this awful?
            vim.schedule(function()
                vim.cmd("normal! zz")
            end)
        end
    end
})

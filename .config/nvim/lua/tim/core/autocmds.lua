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

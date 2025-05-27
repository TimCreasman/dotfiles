vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz", { desc = "Automatically recenter cursor when navigating in a buffer" })
vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz", { desc = "Automatically recenter cursor when navigating in a buffer" })

vim.keymap.set({ "n", "v" }, "<C-o>", "<C-o>zz", { desc = "Automatically recenter cursor when navigating across buffers" })
vim.keymap.set({ "n", "v" }, "<C-i>", "<C-i>zz", { desc = "Automatically recenter cursor when navigating across buffers" })

vim.keymap.set('n', 'x', '"_x', { desc = 'Dot not yank with x' })

vim.keymap.set('n', 'dd', function()
    if vim.fn.getline('.'):match '^%s*$' then
        return '"_dd'
    end
    return 'dd'
end, { expr = true, desc = 'Yank the line on `dd` only if it is non-empty' })

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open diagnostics float"})

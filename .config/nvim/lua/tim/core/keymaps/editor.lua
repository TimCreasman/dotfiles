vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz", { desc = "Automatically recenter cursor when navigating in a buffer" })
vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz", { desc = "Automatically recenter cursor when navigating in a buffer" })

vim.keymap.set({ "n", "v" }, "<C-o>", "<C-o>zz",
    { desc = "Automatically recenter cursor when navigating across buffers" })
vim.keymap.set({ "n", "v" }, "<C-i>", "<C-i>zz",
    { desc = "Automatically recenter cursor when navigating across buffers" })

vim.keymap.set({ "n", "v" }, "G", "Gzz",
    { desc = "Automatically recenter cursor when navigating to bottom of file" })

vim.keymap.set('n', 'x', '"_x', { desc = 'Dot not yank with x' })

vim.keymap.set('n', 'dd', function()
    if vim.fn.getline('.'):match '^%s*$' then
        return '"_dd'
    end
    return 'dd'
end, { expr = true, desc = 'Yank the line on `dd` only if it is non-empty' })

vim.keymap.set({ "x", "n", "s" }, "<leader>w", "<cmd>wa<cr>", { desc = "Save all alias" })

vim.keymap.set({ "x", "n", "s" }, "<leader>x", "<cmd>source %<cr>", { desc = "Execute current lua file" })

vim.keymap.set({ "x", "n", "s" }, "<leader>q", "<cmd>wa<cr><esc><cmd>qa<cr><esc>",
    { desc = "Save all plus quit all done in succession due to terminal not closing nicely" })

-- Harpoon who?
vim.keymap.set("n", "<leader>r1", "mA", { desc = "Mark location and set to 1" })
vim.keymap.set("n", "<leader>r2", "mB", { desc = "Mark location and set to 2" })
vim.keymap.set("n", "<leader>r3", "mC", { desc = "Mark location and set to 3" })

vim.keymap.set("n", "<leader>1", "'Azz", { desc = "Navigate to mark 1, auto recent" })
vim.keymap.set("n", "<leader>2", "'Bzz", { desc = "Navigate to mark 2, auto recent" })
vim.keymap.set("n", "<leader>3", "'Czz", { desc = "Navigate to mark 3, auto recent" })

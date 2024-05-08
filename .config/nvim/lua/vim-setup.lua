-- default to 4 spaces for tab
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- sign column setup
vim.cmd("set signcolumn=yes")
vim.cmd("set updatetime=100")
vim.wo.relativenumber = true

-- combine the windows and wsl clipboards
vim.cmd("set clipboard+=unnamedplus")

-- global keymappings
vim.g.mapleader = " "

vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz")
vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz")

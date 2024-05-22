-- default to 4 spaces for tab
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- no swap files
vim.cmd("set noswapfile")
vim.cmd("set undofile")

-- sign column setup
vim.cmd("set signcolumn=yes")
vim.cmd("set updatetime=100")
vim.wo.number = true
vim.wo.relativenumber = true

-- combine the windows and wsl clipboards
vim.cmd("set clipboard+=unnamedplus")

-- global keymappings
vim.g.mapleader = " "

vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz")
vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz")

-- angular treesitter support setup
vim.filetype.add({
    pattern = {
        -- Sets the filetype to `angular.html` if it matches the pattern
        [".*%.component%.html"] = "angular.html",
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "angular.html",
    callback = function()
        -- Register the filetype with treesitter for the `angular` language/parser
        vim.treesitter.language.register("angular", "angular.html")
    end,
})

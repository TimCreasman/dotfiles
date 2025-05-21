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

-- global clipboard for WSL support
vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
       ['+'] = 'clip.exe',
       ['*'] = 'clip.exe',
     },
    paste = {
       ['+'] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
       ['*'] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
}

-- global keymappings
vim.g.mapleader = " "

vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz")
vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz")

vim.keymap.set({ "n", "v" }, "<C-o>", "<C-o>zz")
vim.keymap.set({ "n", "v" }, "<C-i>", "<C-i>zz")

-- diagnostic shortcut
vim.keymap.set({ "n", "v" }, "<leader>d", vim.diagnostic.open_float, {})

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

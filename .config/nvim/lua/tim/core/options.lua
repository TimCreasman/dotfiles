local utils = require("tim.core.utils")

local opt = vim.opt

-- default to 4 spaces for tab
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

opt.splitbelow = true
opt.splitright = true

opt.swapfile = false
opt.undofile = true

opt.signcolumn = "yes"
opt.updatetime = 800
opt.timeoutlen = 300

opt.scrolloff = 25

vim.wo.number = true
vim.wo.relativenumber = true

vim.diagnostic.config {
    signs = true,
    underline = true,
    virtual_text = false,
    virtual_lines = false,
    update_in_insert = true,
    float = {
        header = '',
        border = 'rounded',
        focusable = true,
    }
}

opt.clipboard = opt.clipboard + "unnamedplus"
-- additional clipboard setup if on wsl
if utils.is_wsl() then
    vim.g.clipboard = {
        name = 'WslClipboard',
        copy = {
            ['+'] = 'clip.exe',
            ['*'] = 'clip.exe',
        },
        paste = {
            ['+'] =
            'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ['*'] =
            'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
end

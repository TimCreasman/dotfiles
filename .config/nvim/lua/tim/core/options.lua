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
opt.updatetime = 100

vim.wo.number = true
vim.wo.relativenumber = true

if utils.is_wsl() then
    -- combine the windows and wsl clipboards
    opt.clipboard = opt.clipboard + "unnamedplus"

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

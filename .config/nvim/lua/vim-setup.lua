-- default to 4 spaces for tab
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- default splitbelow and splitright
vim.cmd("set splitbelow")
vim.cmd("set splitright")

-- no swap files
vim.cmd("set noswapfile")
vim.cmd("set undofile")

-- sign column setup
vim.cmd("set signcolumn=yes")
vim.cmd("set updatetime=100")
vim.wo.number = true
vim.wo.relativenumber = true

-- global clipboard for WSL support
if vim.loop.os_uname().sysname == "Linux" then
    -- combine the windows and wsl clipboards
    vim.cmd("set clipboard+=unnamedplus")

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

-- global keymappings
vim.g.mapleader = " "

vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz", { desc = "Automatically recenter cursor when navigating in a buffer"})
vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz", { desc = "Automatically recenter cursor when navigating in a buffer"})

vim.keymap.set({ "n", "v" }, "<C-o>", "<C-o>zz" , { desc = "Automatically recenter cursor when navigating across buffers"})
vim.keymap.set({ "n", "v" }, "<C-i>", "<C-i>zz" , { desc = "Automatically recenter cursor when navigating across buffers"})

vim.keymap.set('n', 'x', '"_x', { desc = 'Dot not yank with x' })

vim.keymap.set({ "n", "v" }, "<leader>d", vim.diagnostic.open_float, { desc = "Open diagnostic float"})

vim.keymap.set('n', 'dd', function()
    if vim.fn.getline('.'):match '^%s*$' then
        return '"_dd'
    end
    return 'dd'
end, { expr = true, desc = 'Yank the line on `dd` only if it is non-empty' })

-- terminal shortcuts, borrowed from https://github.com/gmr458/nvim/blob/8902ccda7d012d10ae47fdfb6df702bf23f66a96/lua/gmr/core/keymaps/editor.lua#L222
local terminal_buf = nil
local terminal_win_id = nil

local function open_terminal()
    if vim.fn.bufexists(terminal_buf) ~= 1 then
        vim.cmd 'split | term'
        terminal_win_id = vim.fn.win_getid()
        terminal_buf = vim.fn.bufnr '%'
    elseif vim.fn.win_gotoid(terminal_win_id) ~= 1 then
        vim.cmd('sb ' .. terminal_buf)
        terminal_win_id = vim.fn.win_getid()
    end

    vim.cmd 'startinsert'
end

local function hide_terminal()
    if vim.fn.win_gotoid(terminal_win_id) == 1 then
        vim.cmd 'hide'
    end
end

local function toggle_terminal()
    if vim.fn.win_gotoid(terminal_win_id) == 1 then
        hide_terminal()
    else
        open_terminal()
    end
end

vim.keymap.set({ 'n', 't' }, '<leader>t', toggle_terminal, {
    desc = 'toggle terminal',
})

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

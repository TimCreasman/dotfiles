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

vim.keymap.set({ 'n', 't' }, '<leader>tt', toggle_terminal, {
    desc = 'toggle terminal',
})

local function past_reg_in_terminal()
    local next_char_code = vim.fn.getchar()
    local next_char = vim.fn.nr2char(next_char_code)
    return '<C-\\><C-N>"' .. next_char .. 'pi'
end
vim.keymap.set('t', '<c-r>', past_reg_in_terminal, {
    desc = 'Allows pasting registers into the terminal via c-r',
    expr = true
})

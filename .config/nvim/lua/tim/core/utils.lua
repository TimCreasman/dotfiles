local Utils = {}

--- @return boolean
function Utils.is_wsl()
    return vim.loop.os_uname().sysname == "Linux"
end

return Utils;

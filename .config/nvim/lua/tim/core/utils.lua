local Utils = {}

--- @return boolean
function Utils.is_wsl()
    return vim.loop.os_uname().sysname == "Linux"
end

--- Returns the path where the .git folder exists relative
--- to the current buffer or nil if not found
--- @return string?
function Utils.closest_git_dir()
    return vim.fs.root(0, ".git")
end

return Utils;

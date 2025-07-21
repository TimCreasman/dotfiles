local M = {}

-- gdscript is not in mason so maintain a separate list
-- Without this, an annoying error prints on startup
M.configs = {
    -- "angularls",
    -- "cssls",
    -- "emmet_ls",
    -- "eslint",
    -- "html",
    "lua_ls",
    -- "tailwindcss",
    -- "ts_ls",
    "gopls",
    "gdscript",
}

M.mason_ensured_servers = {
    -- "angularls",
    -- "cssls",
    -- "emmet_ls",
    -- "eslint",
    -- "html",
    "lua_ls",
    -- "tailwindcss",
    -- "ts_ls",
    "gopls",
}

return M

vim.filetype.add({
    pattern = {
        [".*%.component%.html"] = "angular.html", -- Sets the filetype to `angular.html` if it matches the pattern
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "angular.html",
    callback = function()
        vim.treesitter.language.register("angular", "angular.html") -- Register the filetype with treesitter for the `angular` language/parser
    end,
})

--[[ -- Note: this is mainly a workaround as this relies on a global angular lsp to be installed
-- If this fails, ensure @angular/language-server, @angular/language-service and typescript are all installed globally
local angularls_path = vim.fn.expand("$MASON/packages/angular-language-server")

local cmd = {
    -- angularls_path .. "/node_modules/@angular/language-server/bin/ngserver",
    -- "--ngProbeLocations",
    -- "/Users/tcreasman/projects/pattern/pattern-console/node_modules",
    -- "--tsProbeLocations",
    -- angularls_path .. "/node_modules",
    -- "--stdio",
} ]]

return {
    filetypes = { "html", "angular.html", "typescript", "typescriptreact", "typescript.tsx" }
}

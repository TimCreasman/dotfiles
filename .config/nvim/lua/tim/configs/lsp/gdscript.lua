local pipe = "/tmp/godot.pipe"

return {
    cmd = { "godot-wsl-lsp", "--useMirroredNetworking" },
    on_attach = function()
        vim.api.nvim_command('echo serverstart("' .. pipe .. '")')
    end
}

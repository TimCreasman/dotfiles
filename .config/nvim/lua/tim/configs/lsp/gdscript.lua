local utils = require("tim.core.utils")

if utils.is_wsl() then
    return {
        cmd = { "godot-wsl-lsp", "--useMirroredNetworking", "--experimentalFastPathConversion" },
    }
else
    return {}
end

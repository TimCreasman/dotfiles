return {
    -- git signs
    {
        "airblade/vim-gitgutter",
    },
    -- macro gutter
    {
        "dsummersl/nvim-sluice",
        config = function()
            require("sluice").setup({})
        end
    },
}

return {
	"maxmx03/solarized.nvim",
	lazy = false,
	priority = 1000,
	config = function()
        require("solarized").setup({
            enables = {
                neotree = false,
                telescope = false,
            }
        })
		vim.o.background = "dark"
		vim.cmd.colorscheme("solarized")
	end,
}

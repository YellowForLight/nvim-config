return {
	"catppuccin/nvim",
    name = "catppuccin",
	priority = 1000,
	config = function() vim.cmd("colorscheme catppuccin-nvim") end,
    dim_inactive = {
        enabled = true
    },
    opts = {
        integrations = {
            mason = true,
            noice = true,
            notify = true,
            lsp_trouble = true,
            gitsigns = true
        }
    },
    dependencies = {
        "vimpostor/vim-lumen"
    }
}

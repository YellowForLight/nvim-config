return {
	"williamboman/mason-lspconfig.nvim",
    opts = {},
	dependencies = {
		"neovim/nvim-lspconfig",
        {
            "williamboman/mason.nvim",
            build = ":MasonUpdate",
            opts = {}
        },
		"mfussenegger/nvim-dap",
		"rcarriga/nvim-dap-ui"
	}
}


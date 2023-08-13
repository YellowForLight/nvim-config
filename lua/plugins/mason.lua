return {
	"williamboman/mason.nvim",
	build = ":MasonUpdate",
	dependencies = {
		"neovim/nvim-lspconfig",
		"williamboman/mason-lspconfig.nvim",
		"mfussenegger/nvim-dap",
		"rcarriga/nvim-dap-ui"
	}
}


return {
	"williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
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
	},
    config = function()
        require("lsp")
        vim.api.nvim_exec_autocmds("FileType", {
            group = "lazyLsp",
            buffer = vim.api.nvim_get_current_buf()
        })
    end
}


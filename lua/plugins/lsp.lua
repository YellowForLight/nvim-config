return {
    "williamboman/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
        "neovim/nvim-lspconfig",
        {
            "williamboman/mason.nvim",
            build = ":MasonUpdate",
            opts = {}
        }
    },
    config = function()
        require("lsp")
    end
}

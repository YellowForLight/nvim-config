return {
    {
        "mason-org/mason.nvim",
        opts = {},
        build = ":MasonUpdate"
    },
    {
        "mason-org/mason-lspconfig.nvim",
        init = function() require("lsp") end,
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig"
        },
        opts = {
            automatic_enable = {
                exclude = {
                    "hls"
                }
            }
        },
    },
    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            {
                "nvimtools/none-ls.nvim",
                dependencies = {"nvim-lua/plenary.nvim"},
                opts = {}
            }
        },
        opts = {
            handlers = {}
        }
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "mfussenegger/nvim-dap"
        },
        opts = {
            handlers = {}
        }
    }
}

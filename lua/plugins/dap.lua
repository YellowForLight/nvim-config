return {
    "rcarriga/nvim-dap-ui",
    opts = {},
    keys = {
        {"<Leader>dc", function() require("dapui").close() end},
        {"<Leader>do", function() require("dapui").open() end},
        {"<Leader>df", function() require("dapui").float_element() end},
        {"<Leader>de", function() require("dapui").eval() end, mode={"n", "v"}}
    },
    dependencies = {
        {
            "mfussenegger/nvim-dap",
            keys = {
                {"<Leader>dd", function() require("dap").continue() end},
                {"<Leader>dj", function() require("dap").step_over() end},
                {"<Leader>dl", function() require("dap").step_into() end},
                {"<Leader>dh", function() require("dap").step_out() end},
                {"<Leader>db", function() require("dap").toggle_breakpoint() end},
                {"<Leader>dB", function() require("dap").set_breakpoint() end},
                {"<Leader>dL", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end},
                {"<Leader>dr", function() require("dap").repl.toggle() end},
                {"<Leader>d;", function() require("dap").run_last() end}
            },
            dependencies = { "mfussenegger/nvim-dap-python",
                {
                    "jay-babu/mason-nvim-dap.nvim",
                    opts = {
                        automatic_installation = true,
                        handlers = {
                            function(config)
                                require("mason-nvim-dap").default_setup(config)
                            end,
                            python = function(config)
                                require("dap-python").setup(require("mason-core.path").package_prefix("debugpy") ..
                                "/venv/bin/python")
                            end
                        }
                    }
                }
            }
        }
    }
}

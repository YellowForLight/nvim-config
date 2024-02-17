return {
    "ms-jpq/coq_nvim",
    branch = "coq",
    event = "VeryLazy",
    init = function()
        vim.g.coq_settings = {
            auto_start = "shut-up",
            keymap = {
                bigger_preview = "<C-S-K>",
                jump_to_mark = "<C-\\>"
            },
            clients = {
                lsp = {
                    always_on_top = {}
                }
            },
            limits = {
                completion_auto_timeout = 0.2
            },
            completion = {
                skip_after = { "[", "]", "{", "}", ",", '"', "'" }
            }
        }
    end,
    build = ":COQdeps",
    dependencies = {
        {
            "ms-jpq/coq.artifacts",
            branch = "artifacts"
        },
        {
            "ms-jpq/coq.thirdparty",
            opts = {
                { src = 'bc', short_name = 'MATH' },
                { src = 'nvimlua', short_name = 'nLua' }
            },
            branch = "3p",
            config = function(plugin, opts)
                require("coq_3p")(opts)
            end
        }
    }
}

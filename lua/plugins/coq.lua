return {
	"ms-jpq/coq_nvim",
	branch = "coq",
	init = function()
		vim.g.coq_settings = {
			auto_start = "shut-up",
			clients = {
				lsp = {
					always_on_top = {}
				}
			},
            limits = {
                completion_auto_timeout = 0.11
            },
            completion = {
                skip_after = {"[", "]", "{", "}", ",", '"', "'"}
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
				{src = 'bc', short_name = 'MATH'}
			},
			branch = "3p",
			config = function(plugin, opts)
				require("coq_3p")(opts)
			end
		}
	}
}

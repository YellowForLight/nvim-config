return {
	"numToStr/Comment.nvim",
	opts = function() return {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
    } end,
	keys = {
		"gcc",
		"gbc",
		"gc",
		"gb",
		"gco",
		"gcO",
		"gcA",
		{"gc", mode = "v"},
		{"gb", mode = "v"}
	},
    dependencies = {
        {
            "JoosepAlviste/nvim-ts-context-commentstring",
            opts = {
                enable_autocmd = false
            }
        },
    }
}

local function telescope(method, opts)
	return function()
		require("telescope.builtin")[method](opts)
	end
end

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	opts = {
	},
	lazy = true,
	cmd = "Telescope",
	keys = {
		{"<leader>gf", telescope("git_files"), desc = "Find [G]it [F]iles"},
		{"<leader>ff", telescope("find_files"), desc = "[F]ind [F]iles"},
		{"<leader>fg", telescope("live_grep"), desc = "[F]ind with [G]rep"},
		{"<leader>fh", telescope("help_tags"), desc = "[F]ind [H]elp"},
		{"<leader>fw", telescope("grep_string"), desc = "[F]ind Current [W]ord"},
		{"<leader>ts", telescope("treesitter"), desc = "Find [T]reesitter [S]ymbol"},
		{"<leader>fd", telescope("diagnostics"), desc = "[F]ind [D]iagnostics"},
		{"<leader>?", telescope("oldfiles"), desc = "[?] Search Old Files"},
		{"<leader>B", telescope("buffers"), desc = "Find [B]uffers"},
		{"<leader>/", telescope("current_buffer_fuzzy_find"), desc = "[/] Find in Current Buffer"}
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make"
		},
		"nvim-tree/nvim-web-devicons"
	},
	config = function(plugin, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("fzf")
	end
}

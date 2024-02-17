return {
	"nvim-treesitter/nvim-treesitter",
	main = "nvim-treesitter.configs",
	build = ":TSUpdate",
    event = "VeryLazy",
	opts = {
		ensure_installed = {"scala", "javascript", "typescript", "lua", "vim", "vimdoc", "comment"},
		auto_install = true,
		highlight = {
			enable = true
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<CR>",
				scope_incremental = "<CR>",
				node_incremental = "<TAB>",
				node_decremental = "<S-TAB>",
			}
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					['aa'] = "@parameter.outer",
					['ia'] = "@parameter.inner",
					['af'] = "@function.outer",
					['if'] = "@function.inner",
					['ac'] = "@class.outer",
					['ic'] = "@class.inner",
					['ai'] = "@conditional.outer",
					['ii'] = "@conditional.inner",
					['al'] = "@loop.outer",
					['il'] = "@loop.inner",
					['as'] = "@statement.outer",
					['is'] = "@statement.inner"
				}
			},
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {
					[']m'] = "@function.outer",
					[']['] = "@class.outer"
				},
				goto_next_end = {
					[']M'] = "@function.outer",
					[']]'] = "@class.outer"
				},
				goto_previous_start = {
					['[m'] = "@function.outer",
					['[['] = "@class.outer"
				},
				goto_previous_end = {
					['[M'] = "@function.outer",
					['[]'] = "@class.outer"
				}
			},
			swap = {
				enable = true,
				swap_next = {
					['<leader>a'] = "@parameter.inner"
				},
				swap_previous = {
					['<leader>A'] = "@parameter.inner"
				}
			}
		},
        matchup = {
            enable = true,
            include_match_words = true
        },
        autotag = {
            enable = true
        },
        endwise = {
            enable = true
        }
	},
	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-context",
			opts = {}
		} ,
		"nvim-treesitter/nvim-treesitter-textobjects",
        {
            "andymass/vim-matchup",
            init = function()
                vim.g.matchup_matchparen_offscreen = { method = "popup" }
                vim.g.matchup_surround_enabled = 1
                vim.g.matchup_matchparen_deferred = 1
                vim.g.matchup_matchparen_hi_surround_always = 1
            end
        },
        "windwp/nvim-ts-autotag",
        "RRethy/nvim-treesitter-endwise"
	}
}

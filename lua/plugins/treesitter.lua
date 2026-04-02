--[[ incremental_selection = {
    enable = true,
    keymaps = {
        init_selection = "<CR>",
        scope_incremental = "<CR>",
        node_incremental = "<TAB>",
        node_decremental = "<S-TAB>",
    }
} ]]
function textobject(key, to)
    return {
        {
            "a" .. key,
            function()
                require("nvim-treesitter-textobjects.select")
                    .select_textobject("@" .. to .. ".outer", "textobjects")
            end,
            mode = {"x", "o"}
        },
        {
            "i" .. key,
            function()
                require("nvim-treesitter-textobjects.select")
                    .select_textobject("@" .. to .. ".inner", "textobjects")
            end,
            mode = {"x", "o"}
        },
        {
            "<leader>s" .. key,
            function()
                require("nvim-treesitter-textobjects.swap")
                    .swap_next("@" .. to .. ".outer")
            end
        },
        {
            "<leader>s" .. string.upper(key),
            function()
                require("nvim-treesitter-textobjects.swap")
                    .swap_previous("@" .. to .. ".outer")
            end
        },
        {
            "]" .. key,
            function()
                require("nvim-treesitter-textobjects.move")
                    .goto_next_start("@" .. to .. ".outer")
            end,
            mode = {"n", "x", "o"}
        },
        {
            "]" .. string.upper(key),
            function()
                require("nvim-treesitter-textobjects.move")
                    .goto_next_end("@" .. to .. ".outer")
            end,
            mode = {"n", "x", "o"}
        },
        {
            "[" .. key,
            function()
                require("nvim-treesitter-textobjects.move")
                    .goto_previous_start("@" .. to .. ".outer")
            end,
            mode = {"n", "x", "o"}
        },
        {
            "[" .. string.upper(key),
            function()
                require("nvim-treesitter-textobjects.move")
                    .goto_previous_end("@" .. to .. ".outer")
            end,
            mode = {"n", "x", "o"}
        },
    }
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        lazy = false,
        init = function()
            local ts = require("nvim-treesitter")
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    local parser = vim.treesitter.language.get_lang(args.match)
                    if not vim.list_contains(ts.get_available(), parser) then
                        return
                    end
                    if not vim.list_contains(ts.get_installed(), parser) then
                        ts.install(parser):wait()
                    end
                    vim.treesitter.start()
                    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    if vim.list_contains({"tex", "typst"}, args.match) then
                        vim.bo.syntax = 'ON'
                    end
                end
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = {"nvim-treesitter/nvim-treesitter"}
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        dependencies = {"nvim-treesitter/nvim-treesitter"},
        keys = vim.list_extend(
            textobject("a", "parameter"),
            vim.list_extend(
                textobject("f", "function"),
                vim.list_extend(
                    textobject("c", "class"),
                    vim.list_extend(
                        textobject("i", "conditional"),
                        vim.list_extend(
                            textobject("l", "loop"),
                            vim.list_extend(
                                textobject("s", "statement"),
                                textobject("k", "block")
                            )
                        )
                    )
                )
            )
        )
    },
    {
        "andymass/vim-matchup",
        dependencies = {"nvim-treesitter/nvim-treesitter"},
        opts = {
            matchparen = {
                offscreen = { method = "popup" },
                deferred = 1,
                hi_surround_always = 1
            },
            motion = {
                override_Npercent = 100
            }
        }
    },
    {
        "windwp/nvim-ts-autotag",
        dependencies = {"nvim-treesitter/nvim-treesitter"},
        opts = {}
    },
    {
        "brianhuster/treesitter-endwise.nvim",
        dependencies = {"nvim-treesitter/nvim-treesitter"}
    }
}

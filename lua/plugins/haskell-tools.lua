return {
    "mrcjkb/haskell-tools.nvim",
    init = function()
        require("lsp")
        vim.g.haskell_tools = {
            dap = {
                cmd = { "haskell-debug-adapter" }
            }
        }
    end,
    ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' }
}

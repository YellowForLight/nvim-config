return {
    "mrcjkb/haskell-tools.nvim",
    init = function()
        vim.g.haskell_tools = {
            hls = {
                cmd = function()
                    local bin = require("mason-core.path").bin_prefix("haskell-language-server-wrapper")
                    return { bin, '--lsp' }
                end,
                capabilities = require('coq').lsp_ensure_capabilities()
            },
            dap = {
                cmd = { require("mason-core.path").bin_prefix("haskell-debug-adapter") }
            }
        }
    end,
    ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' }
}

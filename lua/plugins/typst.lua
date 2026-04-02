return {
    {
        "chomosuke/typst-preview.nvim",
        ft = "typst",
        opts = {
            dependencies_bin = {
                ['tinymist'] = 'tinymist'
            }
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "typst",
                callback = function(event)
                    local opts = {silent = true, noremap = true, buffer = event.buffer}
                    vim.keymap.set("n", "<localleader>ld", ":TypstPreview document<Enter>", opts)
                    vim.keymap.set("n", "<localleader>ls", ":TypstPreview slide<Enter>", opts)
                    vim.keymap.set("n", "<localleader>lD", ":TypstPreviewStop<Enter>", opts)
                    vim.keymap.set("n", "<localleader>lS", ":TypstPreviewStop<Enter>", opts)
                    vim.keymap.set("n", "<localleader>lf", ":TypstPreviewFollowCursor<Enter>", opts)
                    vim.keymap.set("n", "<localleader>lF", ":TypstPreviewNoFollowCursor<Enter>", opts)
                    vim.keymap.set("n", "<localleader>lp", ":TypstPreviewSyncCursor<Enter>", opts)
                end
            })
        end
    },
    {
        "MrPicklePinosaur/typst-conceal.vim"
    }
}

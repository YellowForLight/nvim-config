local relGroup = vim.api.nvim_create_augroup('relative', {})
vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = { "*" },
    group = relGroup,
    callback = function()
        vim.o.rnu = false
    end
})
vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = { "*" },
    group = relGroup,
    callback = function()
        vim.o.rnu = true
    end
})

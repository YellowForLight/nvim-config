vim.keymap.set('i', '<C-O>', '<C-\\><C-O>')
vim.keymap.set('x', 'P', '"_dP')
vim.keymap.set('n', '<leader>Q', vim.cmd.Ex)
vim.keymap.set('n', '<leader>G', '<CMD>G<CR>')
vim.keymap.set('n', '<leader><leader>/', vim.cmd.nohlsearch)
vim.keymap.set('i', '<S-BS>', '<DELETE>')
vim.keymap.set('i', '<C-K>', '<NOP>')
vim.keymap.set('n', '<leader>T', vim.treesitter.inspect_tree)


local ce = vim.api.nvim_replace_termcodes('<C-E>', true, true, true)
local cy = vim.api.nvim_replace_termcodes('<C-Y>', true, true, true)
vim.keymap.set('i', '<C-E>', function()
    vim.api.nvim_feedkeys(ce, 'n', false)
    if pumvisible() then
        vim.api.nvim_feedkeys(ce, 'n', false)
    end
end)


local reindent_selection = vim.api.nvim_replace_termcodes("gv=gv", true, true, true)
vim.keymap.set('x', 'J', function()
    vim.cmd("m '>+1")
    vim.api.nvim_feedkeys(reindent_selection, "m", false)
end)
vim.keymap.set('x', 'K', function()
    vim.cmd("m '<-2")
    vim.api.nvim_feedkeys(reindent_selection, "m", false)
end)

vim.keymap.set('n', '<C-D>', '<C-D>zz')
vim.keymap.set('n', '<C-U>', '<C-U>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', '<leader>j', 'gj')
vim.keymap.set('n', '<leader>k', 'gk')


vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('x', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

vim.keymap.set('n', '<leader>d', '"+d')
vim.keymap.set('x', '<leader>d', '"+d')
vim.keymap.set('n', '<leader>D', '"+D')

vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('v', '<leader>p', '"+p')
vim.keymap.set('n', '<leader>P', '"+P')
vim.keymap.set('v', '<leader>P', '"_d"+P')

vim.keymap.set('x', 'x', '"_x')


vim.keymap.set({'n', 'v', 'i'}, '<UP>', '<NOP>')
vim.keymap.set({'n', 'v', 'i'}, '<RIGHT>', '<NOP>')
vim.keymap.set({'n', 'v', 'i'}, '<DOWN>', '<NOP>')
vim.keymap.set({'n', 'v', 'i'}, '<LEFT>', '<NOP>')

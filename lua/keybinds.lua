vim.keymap.set('i', '<C-O>', '<C-\\><C-O>')
vim.keymap.set('x', 'P', '"_dP')
vim.keymap.set('n', '<leader>Q', vim.cmd.Ex)
vim.keymap.set('n', '<leader><leader>/', ':noh<CR>')
vim.keymap.set('i', '<S-BS>', '<DELETE>')

vim.keymap.set('x', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('x', 'K', ":m '<-2<CR>gv=gv")

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

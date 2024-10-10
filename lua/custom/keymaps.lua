-- Move current line down
vim.api.nvim_set_keymap('n', '<leader>ld', ':m+1<CR>', { noremap = true, silent = true })

-- Move current line up
vim.api.nvim_set_keymap('n', '<leader>lu', ':m-2<CR>', { noremap = true, silent = true })


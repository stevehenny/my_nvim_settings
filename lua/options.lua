require("nvchad.options")

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- vim.o.guicursor = "v-n:block-blinkwait700-blinkoff400-blinkon250,v-c:block,i-ci:block,r:block"
vim.o.guicursor = "v-n-c-i-ci-r:block-blinkwait700-blinkoff400-blinkon250"
vim.opt.number = true
vim.opt.relativenumber = true
vim.api.nvim_set_keymap("n", "<leader>ld", ":m+1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>lu", ":m-2<CR>", { noremap = true, silent = true })

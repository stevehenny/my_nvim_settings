require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

vim.api.nvim_set_keymap('n', '<leader>ld', ':m+1<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lu', ':m-2<CR>', { noremap = true, silent = true })
dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
vim.opt.number = true
vim.opt.relativenumber = true
vim.o.guicursor = "n:block-blinkwait700-blinkoff400-blinkon250,v-c:block,i-ci:block,r:block"
require "plugins"

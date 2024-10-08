-- Setting the filetype for Verilog
vim.api.nvim_create_autocmd(
  {"BufNewFile", "BufRead"}, {
    pattern = {"*.v"},
    command = "set filetype=verilog",
  }
)

-- Setting the filetype for SystemVerilog
vim.api.nvim_create_autocmd(
  {"BufNewFile", "BufRead"}, {
    pattern = {"*.sv"},
    command = "set filetype=systemverilog",
  }
)

-- Formatter for Verilog files using verible-verilog-format
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = {"*.v", "*.sv"},
  callback = function()
    local home_dir = os.getenv("HOME")
    -- Run the Verible formatter
    vim.fn.jobstart({home_dir .. "/.local/share/nvim/mason/bin/verible-verilog-format", "--inplace", vim.fn.expand("%")})
  end,
})

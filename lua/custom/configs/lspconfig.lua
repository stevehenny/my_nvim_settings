local config = require("plugins.configs.lspconfig")

local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require("lspconfig")


lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"python"},
})

lspconfig.clangd.setup({
  on_attach = function(client, bufner)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufner)
  end,
  capabilities = capabilities
})

lspconfig.asm_lsp.setup({
  on_attach = function(client, bufner)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufner)
  end,
  capabilities = capabilities
})

lspconfig.verible.setup({
  on_attach = function(client, bufner)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufner)
  end,
  capabilities = capabilities
})


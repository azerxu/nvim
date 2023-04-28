-- Require LSP config which we can use to attach gopls
local lsp_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_ok then
    vim.notify("jsonls.lua load lspconfig failed!")
    return
end


-- Since we installed lspconfig and imported it, we can reach
-- gopls by lspconfig.gopls
-- we can then set it up using the setup and insert the needed configurations
-- on_attach = require("lsp-inlayhints").on_attach,
-- on_attach = require("virtualtypes").on_attach,
lspconfig.jsonls.setup({
})

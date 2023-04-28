-- Require LSP config which we can use to attach gopls
local lsp_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_ok then
    vim.notify("gopls.lua load lspconfig failed!")
    return
end


-- Since we installed lspconfig and imported it, we can reach
-- gopls by lspconfig.gopls
-- we can then set it up using the setup and insert the needed configurations
-- on_attach = require("lsp-inlayhints").on_attach,
-- on_attach = require("virtualtypes").on_attach,
lspconfig.gopls.setup({
    -- on_attach = require("inlay-hints").on_attach,
    root_dir = function()
        return vim.fn.getcwd()
    end,
    flags = {
        debounce_text_changes = 150,
    },
    cmd = { "gopls", "serve" },
    filetypes = { "go", "gomod" },
    settings = {
        gopls = {
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
            -- semamticTokens = true,
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
})

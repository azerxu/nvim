local lsp_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_ok then
    vim.notify("pyright.lua load lspconfig failed!")
    return
end

lspconfig.pyright.setup({
    -- cmd = { 'pyright-langserver', '--stdio' },
    -- on_attach = require("virtualtypes").on_attach,
    -- capabilities = config.capabilities,
    root_dir = function()
        return vim.fn.getcwd()
    end,
    flags = {
        debounce_text_changes = 150,
    },
    filetypes = { "python" },
    single_file_support = true,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "basic",
                inlayHints = {
                    enabled = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayParameterNameHints = true,
                    includeInlayParameterNameHintsWhenPositional = true,
                    includeInlayVariableTypeHints = true,
                },
            },
        },
    },
})

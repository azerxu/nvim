-----------------------------------------------------------------------------------------------
-- Show line diagnostics automatically in hover window
-----------------------------------------------------------------------------------------------
vim.cmd([[
  autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })
]])

-----------------------------------------------------------------------------------------------
-- 设置Diagnostics
-----------------------------------------------------------------------------------------------
local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end

sign({ name = 'DiagnosticSignError', text = '' })
sign({ name = 'DiagnosticSignWarn', text = '' })
sign({ name = 'DiagnosticSignHint', text = '' })
sign({ name = 'DiagnosticSignInfo', text = '' })


-----------------------------------------------------------------------------------------------
-- Diagnostic settings:
-- see: `:help vim.diagnostic.config`
-- Customizing how diagnostics are displayed
-----------------------------------------------------------------------------------------------
vim.diagnostic.config({
    virtual_text = true,      -- Show diagnostic message using virtual text.
    signs = true,             -- Show a sign next to the line with a diagnostic
    update_in_insert = false, -- update diagnostic while editing in insert mode
    underline = true,         -- use an underline to show a diagnostic location
    severity_sort = false,    -- order diagnostics by severity
    -- float = true,             -- show diagnostic message in floating window
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    }
})


vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
)

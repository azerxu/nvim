-- local config_ok, config = pcall(require, "lsp.config")
-- if not config_ok then
--     vim.notify("pylsp.lua load lsp.config failed!")
--     return
-- end

local lsp_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_ok then
    vim.notify("pylsp.lua load lspconfig failed!")
    return
end

lspconfig.pylsp.setup({
    on_attach = require("virtualtypes").on_attach,
    root_dir = function()
        return vim.fn.getcwd()
    end,
    settings = {
        pylsp = {
            configurationSources = { "flake8", "pycodestyle" },
            plugins = {
                autopep8 = {
                    enabled = false,
                },
                pycodestyle = {
                    enabled = true,
                    exclude = {},
                    -- ignore = {'W391'},
                    ignore = { 'E203' },
                    indentSize = 4,
                    maxLineLength = 100,
                },
                mccabe = {
                    enabled = true,
                },
                pyflakes = {
                    enabled = false,
                },
                yapf = {
                    enabled = true,
                },
                black = {
                    enable = true,
                    indentSize = 4,
                    maxLineLength = 100,
                },
                flake8 = {
                    enabled = true,
                    exclude = {},
                    ignore = { 'E203' },
                    indentSize = 4,
                    maxLineLength = 100,
                },
                pylint = {
                    enabled = false,
                    executable = "pylint",
                },
            },
        },
    },
})

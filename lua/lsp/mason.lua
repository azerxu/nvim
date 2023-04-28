local icons = require("icons")

require('mason').setup({
    ui = {
        icons = {
            package_installed = icons.lsp.server_installed,
            package_pending = icons.lsp.server_pending,
            package_uninstalled = icons.lsp.server_uninstalled,
            -- package_installed = "✓",
            -- package_pending = "➜",
            -- package_uninstalled = "✗"
        }
    }
})

require('mason-lspconfig').setup({
    -- A list of servers to automatically install if they're not already installed
    ensure_installed = { 'pylsp', 'gopls', 'lua_ls', 'rust_analyzer', 'pyright' },
    automatic_installation = false,
})

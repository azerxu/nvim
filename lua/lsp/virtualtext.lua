-----------------------------------------------------------------------------------------------
-- Virtual Text Config
-----------------------------------------------------------------------------------------------
local virtual_group = vim.api.nvim_create_augroup("LspAttach_virtualText", {})
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "virtual text",
    group = virtual_group,
    callback = function(args)
        if not (args.data and args.data.client_id) then
            vim.notify("LspAttach_virtualText Error")
            return
        end

        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.codeLensProvider then
            vim.notify(client.name .. " start LspAttach_virtualText ...")
            require("virtualtypes").on_attach(client, bufnr)
            local codelens = vim.api.nvim_create_augroup('LSPCodeLens', { clear = true })
            vim.api.nvim_create_autocmd({ 'BufEnter' }, {
                group = codelens,
                callback = function()
                    vim.lsp.codelens.refresh()
                end,
                buffer = bufnr,
                once = true,
            })
            vim.api.nvim_create_autocmd({ 'BufWritePost', 'CursorHold' }, {
                group = codelens,
                callback = function()
                    vim.lsp.codelens.refresh()
                end,
                buffer = bufnr,
            })
            vim.notify(client.name .. " start LspAttach_virtualText done")
        else
            vim.notify(client.name .. " don't support textDocument/codelens")
        end
    end,
})

-----------------------------------------------------------------------------------------------
-- Setting auto format on save
-----------------------------------------------------------------------------------------------
local fmt_group = vim.api.nvim_create_augroup("LspAttach_fmtOnSave", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
    group = fmt_group,
    callback = function(args)
        if not (args.data and args.data.client_id) then
            vim.notify("LspAttach_fmtOnSave Error")
            return
        end

        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- if client.supports_method("textDocument/formatting") then
        if client.server_capabilities.documentFormattingProvider then
            vim.notify(client.name .. " start LspAttach_fmtOnSave ...")
            local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                desc = "Auto Format",
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
            vim.notify(client.name .. " start LspAttach_fmtOnSave done")
        else
            vim.notify(client.name .. " don't support textDocument/formatting")
        end
    end,
})

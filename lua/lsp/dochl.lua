-----------------------------------------------------------------------------------------------
-- Highlighting references.
-- See: https://sbulav.github.io/til/til-neovim-highlight-references/
-- for the highlight trigger time see: `vim.opt.updatetime`
-----------------------------------------------------------------------------------------------
local dochl_group = vim.api.nvim_create_augroup("LspAttach_DocHL", {})
vim.api.nvim_create_autocmd("LspAttach", {
    group = dochl_group,
    callback = function(args)
        if not (args.data and args.data.client_id) then
            vim.notify("LspAttach_DocHL Error")
            return
        end

        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.documentHighlightProvider then
            vim.notify(client.name .. " start LspAttach_DocHL ...")
            local augroup = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("CursorHold", {
                callback = vim.lsp.buf.document_highlight,
                buffer = bufnr,
                group = augroup,
                desc = "Document Highlight",
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
                callback = vim.lsp.buf.clear_references,
                buffer = bufnr,
                group = augroup,
                desc = "Clear All the References",
            })
            vim.notify(client.name .. " start LspAttach_DocHL done")
        end
    end,
})

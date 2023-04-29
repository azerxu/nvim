-----------------------------------------------------------------------------------------------
-- Setting navic
-----------------------------------------------------------------------------------------------
local navic_group = vim.api.nvim_create_augroup("LspAttach_Navic", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
    group = navic_group,
    callback = function(args)
        if not (args.data and args.data.client_id) then
            vim.notify("LspAttach_Navic Error")
            return
        end

        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.documentSymbolProvider then
            -- vim.notify(client.name .. " start LspAttach_Navic ...")
            require("nvim-navic").attach(client, args.buf)
            -- vim.notify(client.name .. " start LspAttach_Navic done")
        else
            vim.notify(client.name .. " don't support textDocument/Symbol")
        end
    end,
})

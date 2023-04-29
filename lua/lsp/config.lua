-----------------------------------------------------------------------------------------------
-- Neovim will emit the event `LspAttach` each time a language server is attached to a buffer,
-- this will give us the opportunity to create our keybindings.
-----------------------------------------------------------------------------------------------
local key_group = vim.api.nvim_create_augroup("LspAttach_keyMap", {})
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    group = key_group,
    callback = function(args)
        -- Enable completion triggered by <c-x><c-o>
        -- vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local buffer = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local caps = client.server_capabilities

        -- Buffer local key mappings settings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufmap = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = buffer, desc = desc })
        end

        if caps.typeDefinitionProvider then
            bufmap("n", ";t", vim.lsp.buf.type_definition, 'go type definition')
        end

        if caps.declarationProvider then
            bufmap("n", ";D", vim.lsp.buf.declaration, 'go declaration')
        end

        if caps.difinitionProvider then
            bufmap("n", ";d", vim.lsp.buf.definition, 'go definition')
        end

        if caps.referencesProvider then
            bufmap("n", ";r", vim.lsp.buf.references, 'go references')
        end

        if caps.implementationProvider then
            bufmap("n", ";i", vim.lsp.buf.implementation, 'go implementation')
        end

        if caps.signatureHelpProvider then
            bufmap("n", ";s", vim.lsp.buf.signature_help, 'go signature help')
        end

        if caps.hoverProvider then
            bufmap("n", "K", vim.lsp.buf.hover, 'on hover show')
        end

        if caps.renameProvider then
            bufmap("n", ";rn", vim.lsp.buf.rename, 'rename')
        end

        if caps.codeActionProvider then
            bufmap({ "n", "v", "x" }, ";ca", vim.lsp.buf.code_action, 'code action')
        end

        if caps.documentRangeFormattingProvider then
            bufmap({"n", "v", "x"}, ";g", function()
                vim.lsp.buf.range_formatting()
            end, 'do range format')
        end

        if caps.documentFormattingProvider or caps.documentOnTypeFormattingProvider then
            bufmap("n", ";f", function()
                vim.lsp.buf.format({ async = true })
            end, 'do format')
        end

        bufmap("n", ";wa", vim.lsp.buf.add_workspace_folder, 'add workspace folder')
        bufmap("n", ";wr", vim.lsp.buf.remove_workspace_folder, 'remove workspace folder')
        bufmap("n", ";wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, 'list workspace folders')

        bufmap("n", ";e", vim.diagnostic.open_float, 'open diagnostic on float')
        bufmap("n", "z[", vim.diagnostic.goto_prev, 'goto prev diagnostic')
        bufmap("n", "z]", vim.diagnostic.goto_next, 'goto next diagnostic')
        bufmap("n", ";q", vim.diagnostic.setloclist, 'set diagnostic loclist')
    end,
})

-----------------------------------------------------------------------------------------------
-- Global Config
-----------------------------------------------------------------------------------------------
local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

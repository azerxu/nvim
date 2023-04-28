---------------------------------------
-- lua luanguage server Setting
---------------------------------------
local lsp_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_ok then
    vim.notify("luals.lua load lspconfig failed!")
    return
end

local on_attach = function(client, bufnr)
    local caps = client.server_capabilities

    if caps.completionProvider then
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end

    if caps.documentFormattingProvider then
        vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"
    end

    if caps.definitionProvider then
        vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

    -- if caps.documentSymbolProvider then
    --     local navic = require("nvim_navic")
    -- end

    -- require("inlay-hints").on_attach(client, bufnr)
end

lspconfig.lua_ls.setup({
    on_attach = on_attach,
    root_dir = function()
        return vim.fn.getcwd()
    end,
    flags = {
        debounce_text_changes = 150,
    },
    settings = {
        Lua = {
            hint = {
                enable = true,
                arrayIndex = "Enable",
                paramName = "All",
                paramType = true,
                semicolon = "All",
                setType = true,
            },
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
                neededFileStatus = "Any",
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
            format = {
                enable = true,
                -- Put format options here
                -- Note: the value should be String!!
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "4",
                    max_line_length = "120",
                    continuation_indent = "8",
                    quote_style = 'double',
                    align_call_args = true,
                    align_function_params = true,
                    line_space_after_if_statement = "keep",
                    line_space_after_do_statement = "keep",
                    line_space_after_while_statement = "keep",
                    line_space_after_repeat_statement = "keep",
                    line_space_after_for_statement = "keep",
                    line_space_after_local_or_assign_statement = "keep",
                    line_space_after_function_statement = "fixed(2)",
                    line_space_after_expression_statement = "keep",
                    line_space_after_comment = "max(1)",
                },
            },
        },
    },
})

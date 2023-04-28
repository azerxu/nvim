-----------------------------------------------------------------------------------------------
-- completeopt is used to manage code suggestions
-- menuone: show popup even when there is only one suggestion
-- noinsert: Only insert text when selection is confirmed
-- noselect: force us to select one from the suggestions
-----------------------------------------------------------------------------------------------
vim.opt.completeopt = { "menuone", "noselect", "noinsert", "preview" }

-- shortmess is used to avoid excessive messages
vim.opt.shortmess = vim.opt.shortmess + { c = true }

local snip_ok, luasnip = pcall(require, "luasnip")
if not snip_ok then
    vim.notify("cmp.lua load luansnip failed!")
    return
end

-- load friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()

local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
    vim.notify("cmp.lua load nvim-cmp failed!")
    return
end

local kind_ok, lspkind = pcall(require, "lspkind")
if not kind_ok then
    vim.notify("cmp.lua load lspkind failed!")
end


-----------------------------------------------------------------------------------------------
-- 设置 Nvim-Cmp
-----------------------------------------------------------------------------------------------
local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    -- REQUIRED - you must specify a snippet engine
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users
        end,
    },
    sources = { -- sources are the installed sources that can be used for code suggestions
        { name = "path" },
        { name = "git" },
        { name = "nvim_lua" },
        { name = "nvim_lsp",     keyword_length = 1 },
        { name = "buffer",       keyword_length = 3 },
        { name = "luasnip",      keyword_length = 2 },
        { name = "orgmode",      keyword_length = 2 },
        { name = "lsp_signature" },
        -- { name = "nvim_lsp_signature_help" },
    },
    -- completion = {
    -- 	completeopt = "menu,menuone,noinsert",
    -- },
    window = {
        -- add borders to windows
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = {
        -- Add Mappings to control the code suggestions
        ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
        ['<Down>'] = cmp.mapping.select_next_item(select_opts),
        ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
        ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
        -- Shift+TAB to go to the Previous Suggested item
        -- ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        -- Tab to go to the next suggestion
        -- ["<Tab>"] = cmp.mapping.select_next_item(),
        -- CTRL+u to scroll backwards in description
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        -- CTRL+d to scroll forwards in the description
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        -- CTRL+e to bring up completion at current Cursor __cpLocation
        ["<C-e>"] = cmp.mapping.close(),
        -- CTRL+SPACE to toggle completion
        ["<C-Space>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.abort()
            else
                cmp.complete()
            end
        end),
        -- CR (enter or return) to CONFIRM the currently selection suggestion
        -- We set the ConfirmBehavior to insert the Selected suggestion
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<CR>"] = cmp.mapping.confirm({
            -- behavior = cmp.ConfirmBehavior.Insert,
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        }),
        -- setting snippet binding, jump next
        ["<C-f>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        -- setting snippet binding, jump previous
        ["<C-b>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        -- if menu is visible, navigate to next item
        -- if line is empty, insert a tab character
        -- if Cursor is inside a word, trigger the completion menu
        ["<Tab>"] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.jumpable(1) then
                luasnip.jump(1)
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
            else
                cmp.complete()
            end
        end, { "i", "s" }),
        -- when menu is visible, navigate to previous item on lists
        -- else revert to default behavior
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },
    formatting = {
        -- add formating of the different sources
        fields = { "menu", "abbr", "kind" },
        format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            menu = {
                nvim_lsp = "λ",
                luasnip = "🖫",
                nvim_lua = "",
                path = "",
                buffer = "Ω",
                emoji = "\u{f0785}",
                omni = "",
            },
        }),
    },
})

cmp.setup.filetype("gitcommit", {
    -- set configuration for specific filetype
    sources = cmp.config.sources({
        { name = "cmp_git" }, -- you can specify the `cmp_git` source if you were installed it.
    }, {
        { name = "buffer" },
    }),
})

-- use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore)
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

-- use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore)
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

--  see https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu
vim.cmd([[
  highlight! link CmpItemMenu Comment
  " gray
  highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
  " blue
  highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
  highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
  " light blue
  highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
  " pink
  highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
  highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
  " front
  highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
]])

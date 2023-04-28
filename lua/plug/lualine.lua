local colors = {
    red         = "#ca1243",
    red2        = '#ec5f67',
    grey        = "#a0a1a7",
    black       = "#383a42",
    white       = "#f3f3f3",
    light_green = "#83a598",
    orange      = "#fe8019",
    orange2     = '#FF8800',
    green       = "#8ec07c",
    green2      = '#98be65',
    yellow      = '#ECBE7B',
    bg          = '#202328',
    fg          = '#bbc2cf',
    cyan        = '#008080',
    darkblue    = '#081633',
    violet      = '#a9a1e1',
    blue        = '#51afef',
    magenta     = '#c678dd',
}


local function modified()
    if vim.bo.modified then
        return "+"
    elseif vim.bo.modifiable == false or vim.bo.readonly == true then
        return ""
    end
    return ""
end

-- add pastetoggle status
local function pasted()
    if vim.o.paste then
        return "Þ"
    end
    return ""
end

vim.opt.showmode = false

-- ins_left {
--   'diagnostics',
--   sources = { 'nvim_diagnostic' },
--   symbols = { error = ' ', warn = ' ', info = ' ' },
--   diagnostics_color = {
--     color_error = { fg = colors.red },
--     color_warn = { fg = colors.yellow },
--     color_info = { fg = colors.cyan },
--   },
-- }

local function lsped()
    local msg = "No Active Lsp"
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    vim.notify("find filetype ")
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
        vim.notify("find no clients")
        return msg
    end
    local names = ""
    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            vim.notify("find clients: " .. client.name)
            if names == "" then
                names = client.name
            else
                names = names .. client.name
            end
        end
    end
    if names == "" then
        return msg
    else
        return names
    end
end
-- ins_left {
--   -- Lsp server name .
--   function()
--     local msg = 'No Active Lsp'
--     local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
--     local clients = vim.lsp.get_active_clients()
--     if next(clients) == nil then
--       return msg
--     end
--     for _, client in ipairs(clients) do
--       local filetypes = client.config.filetypes
--       if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
--         return client.name
--       end
--     end
--     return msg
--   end,
--   icon = ' LSP:',
--   color = { fg = '#ffffff', gui = 'bold' },
-- }

vim.notify(lsped())

require("lualine").setup({
    options = {
        -- 设置主题颜色
        theme = "onedark",
        -- theme = "molokai",
        icons_enabled = true,
        -- component_separators = "|",
        -- section_separators = "",
        disabled_filetypes = {
            statusline = { 'NvimTree' },
        }
    },
    sections = {
        lualine_c = {
            {
                "filename",
                file_status = false,
                path = 1
            },
            --            { lsped,    color = { bg = colors.bg, fg = colors.fg, gui = "bold" },      icon = " LSP:" },
            { pasted,   color = { bg = colors.green, fg = colors.white, gui = "bold" } },
            { modified, color = { bg = colors.cyan, fg = colors.white, gui = "bold" } },
            {
                "diagnostics",
                source = { "nvim" },
                sections = { "error" },
                diagnostics_color = { error = { bg = colors.red, fg = colors.white, gui = "bold" } },
            },
            {
                "diagnostics",
                source = { "nvim" },
                sections = { "warn" },
                diagnostics_color = { warn = { fg = colors.yellow, bg = colors.bg, gui = "bold" } },
            },
            {
                "diagnostics",
                source = { "nvim_diagnostic" },
                sections = { "info" },
                diagnostics_color = { info = { bg = colors.blue, fg = colors.white, gui = "bold" } },
            },


            {
                "%w",
                cond = function()
                    return vim.wo.previewwindow
                end,
            },
            {
                "%q",
                cond = function()
                    return vim.bo.buftype == "quickfix"
                end,
            },
        },
        -- lualine_x = {
        --     {
        --         'fileformat',
        --         icons_enabled = true,
        --         symbols = {
        --             unix = '',
        --             dos = 'CRLF',
        --             mac = 'CR',
        --         }
        --     },
        --     'filetype', 'encoding',
        -- },
    },
})

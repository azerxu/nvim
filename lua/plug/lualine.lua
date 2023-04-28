vim.opt.showmode = false

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

local icons = {
    Lock = "",
    Modified = "+",
    Paste = "Þ",
    Error = ' ',
    Warn = ' ',
    Info = ' ',
    Hint = " ",
    Lsp = " LSP:",

}

local function modified()
    if vim.bo.modified then
        return icons.Modified
    elseif vim.bo.modifiable == false or vim.bo.readonly == true then
        return icons.Lock
    end
    return ""
end

-- add pastetoggle status
local function pasted()
    if vim.o.paste then
        return icons.Paste
    end
    return ""
end


local function lsp_client()
    local clients = vim.lsp.get_active_clients()
    local names = {}
    for _, client in ipairs(clients) do
        table.insert(names, client.name)
    end
    if names ~= {} then
        return "" .. table.concat(names, "|")
    end
    return "No Active Lsp"
end

require("lualine").setup({
    options = {
        theme = "onedark",
        icons_enabled = true,
        disabled_filetypes = {
            statusline = { 'NvimTree' },
        }
    },
    sections = {
        lualine_a = {

        },
        lualine_b = {

        },
        lualine_c = {
            {
                "filename",
                file_status = false,
                path = 1
            },
            {
                lsp_client,
                color = {
                    bg = colors.bg,
                    fg = colors.fg,
                    gui = "bold"
                },
                icon = icons.Lsp,
            },
            {
                pasted,
                color = {
                    bg = colors.green,
                    fg = colors.white,
                    gui = "bold"
                }
            },
            {
                modified,
                color = {
                    bg = colors.cyan,
                    fg = colors.white,
                    gui = "bold"
                }
            },
            {
                "diagnostics",
                source = { "nvim_diagnostic" },
                sections = { "error" },
                diagnostics_color = { error = { bg = colors.red, fg = colors.white, gui = "bold" } },
            },
            {
                "diagnostics",
                source = { "nvim_diagnostic" },
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
                "diagnostics",
                source = { "nvim_diagnostic" },
                sections = { "hint" },
                diagnostics_color = { hint = { bg = colors.blue, fg = colors.white, gui = "bold" } },
            },

        },
        lualine_x = {

        },
        lualine_y = {

        },
        lualine_z = {

        },
    },
})

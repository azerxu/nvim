vim.opt.showmode = false

local colors = {
    red         = "#ca1243",
    red2        = '#ec5f67',
    grey        = "#a0a1a7",
    black       = "#383a42",
    purple      = '#c678dd',
    white       = "#f3f3f3",
    light_green = "#83a598",
    orange      = "#fe8019",
    orange2     = '#FF8800',
    green       = "#8ec07c",
    green2      = '#98be65',
    yellow      = '#ECBE7B',
    dark        = "#2a2d2d",
    deepdark    = "#1a1d1d",
    lightdark   = "#2e2f2f",
    bg          = '#202328',
    fg          = '#bbc2cf',
    cyan        = '#008080',
    darkblue    = '#081633',
    violet      = '#a9a1e1',
    blue        = '#51afef',
    magenta     = '#c678dd',
    gray1       = '#828997',
    gray2       = '#2c323c',
    gray3       = '#3e4452',
}

local icons = {
    Lock = "",
    Paste = "Þ",
    Error = ' ',
    Warn = ' ',
    Info = ' ',
    Hint = " ",
    Lsp = " LSP:",
    Readonly = "",
    Whitespace = "☲",
    Linenr = "",
    Mlinenr = "☰",
    Colnr = "℅",
    Branch = "",
    Nonexists = "Ɇ",
    Crypt = "🔒",
    Dirty = "⚡",
    Logo = "",
    Bar = "▊",
    Changed = "+",
    Added = ' ',
    Modified = '柳 ',
    Removed = ' ',
    left_comp = "",
    right_comp = "",
    left_sect = "",
    right_sect = "",
}


local theme = {
    normal = {
        a = { fg = colors.bg, bg = colors.green, gui = "bold" },
        b = { fg = colors.fg, bg = colors.gray3 },
        c = { fg = colors.fg, bg = colors.deepdark },
    },
    command = { a = { fg = colors.bg, bg = colors.yellow, gui = "bold" } },
    insert = { a = { fg = colors.bg, bg = colors.blue }, gui = "bold" },
    visual = { a = { fg = colors.bg, bg = colors.purple }, gui = "bold" },
    terminal = { a = { fg = colors.bg, bg = colors.cyan }, gui = "bold" },
    replace = { a = { fg = colors.bg, bg = colors.red }, gui = "bold" },

    inactive = {
        a = { fg = colors.gray1, bg = colors.bg, gui = "bold" },
        b = { fg = colors.gray1, bg = colors.bg },
        c = { fg = colors.gray1, bg = colors.gray2 },
    },
}



local function status_line()
    local mode = "%-5{%v:lua.string.upper(v:lua.vim.fn.mode())%}"
    local file_name = "%-.16t"
    local buf_nr = "[%n]"
    local modi = " %-m"
    local file_type = " %y"
    local right_align = "%="
    local line_no = "%10([%l/%L%)]"
    local pct_thru_file = "%5p%%"
    local all_show = "%9([%l/%L%)]:%p%%"
    -- local all_show = "%5p%% %y%10(%[l/%L%)]"

    return string.format(
        "%s%s%s%s%s%s%s%s%s",
        mode,
        file_name,
        buf_nr,
        modi,
        file_type,
        right_align,
        line_no,
        pct_thru_file,
        all_show
    )
end

-- vim.opt.statusline = status_line()
-- vim.opt.winbar = status_line()

local function bared()
    return icons.Bar
end

local function logoed()
    return icons.Logo
end

local function stated()
    -- return "%c:%l %5p%%:%8([%l/%L%)]"
    return "%c:%l %5p%%:%8l/%L"
end

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
    local ft = vim.o.ft
    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, ft) ~= -1 then
            table.insert(names, client.name)
        end
    end
    if names ~= {} then
        return "" .. table.concat(names, "|")
    end
    return "No Active Lsp"
end

local function search_result()
    if vim.v.hlsearch == 0 then
        return ''
    end
    local last_search = vim.fn.getreg('/')
    if not last_search or last_search == '' then
        return ''
    end
    local searchcount = vim.fn.searchcount { maxcount = 9999 }
    return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
end




require("lualine").setup({
    options = {
        theme = theme,
        icons_enabled = true,
        -- component_separators = { left = '', right = ''},
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {
                'NvimTree',
            },
            winbar = {
                "trouble",
            },
        },
        ignore_focus = {},
        always_divide_middle = false,
        globalstatus = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {
            {
                bared,
                padding = { right = 1 },
                color = {
                    bg = colors.bg,
                    fg = colors.blue,
                    gui = "bold",
                }
            },
            {
                logoed,
                padding = { right = 1 },
                color = function()
                    -- auto change color according to neovims mode
                    local mode_color = {
                        n = colors.red,
                        i = colors.green,
                        v = colors.blue,
                        [''] = colors.blue,
                        V = colors.blue,
                        c = colors.magenta,
                        no = colors.red,
                        s = colors.orange,
                        S = colors.orange,
                        [''] = colors.orange,
                        ic = colors.yellow,
                        R = colors.violet,
                        Rv = colors.violet,
                        cv = colors.red,
                        ce = colors.red,
                        r = colors.cyan,
                        rm = colors.cyan,
                        ['r?'] = colors.cyan,
                        ['!'] = colors.red,
                        t = colors.red,
                    }
                    return { fg = mode_color[vim.fn.mode()], bg = colors.bg }
                end,
                separator = "",
            },
            {
                "mode",
                fmt = function(str)
                    if str == "V-BLOCK" then
                        return "B"
                    end
                    return str:sub(1, 1)
                end,
            },
        },
        lualine_b = {
        },
        lualine_c = {
            {
                "filename",
                file_status = false,
                path = 1,
                color = { fg = colors.purple, gui = "bold" },
                separator = "",
                -- separator = { right = icons.left_comp },
            },
            {
                lsp_client,
                separator = { left = icons.left_comp },
                color = {
                    bg = colors.lightdark,
                    fg = colors.violet,
                    gui = "bold"
                },
                icon = icons.Lsp,
            },
            {
                pasted,
                separator = { left = icons.left_comp },
                color = {
                    bg = colors.green,
                    fg = colors.white,
                    gui = "bold"
                }
            },
            {
                "branch",
                separator = { left = icons.left_comp },
            },
            {
                modified,
                separator = { left = icons.left_comp },
                color = {
                    bg = colors.cyan,
                    fg = colors.white,
                    gui = "bold"
                }
            },
            {
                "diagnostics",
                separator = { left = icons.left_comp },
                source = { "nvim_diagnostic" },
                sections = { "error" },
                diagnostics_color = { error = { bg = colors.red, fg = colors.white, gui = "bold" } },
            },
            {
                "diagnostics",
                separator = { left = icons.left_comp },
                source = { "nvim_diagnostic" },
                sections = { "warn" },
                diagnostics_color = { warn = { fg = colors.yellow, bg = colors.bg, gui = "bold" } },
            },
            {
                "diagnostics",
                separator = { left = icons.left_comp },
                source = { "nvim_diagnostic" },
                sections = { "info" },
                diagnostics_color = { info = { bg = colors.blue, fg = colors.white, gui = "bold" } },
            },
            {
                "diagnostics",
                separator = { left = icons.left_comp },
                source = { "nvim_diagnostic" },
                sections = { "hint" },
                diagnostics_color = { hint = { bg = colors.blue, fg = colors.white, gui = "bold" } },
            },

        },
        lualine_x = {
            {
                search_result,
                separator = { left = icons.left_comp },
            },
            {
                "encoding",
                separator = { left = icons.left_comp },
            },
            {
                "fileformat",
                separator = { left = icons.left_comp },
            },
            {
                "filetype",
                separator = { left = icons.left_comp },
            },
            {
                "progress",
                separator = { left = icons.left_comp },
            },
            {
                "location",
                separator = { left = icons.left_comp },
            },
        },
        lualine_y = {

        },
        lualine_z = {
            {
                stated,
                padding = { left = 1, right = 1 },
                -- separator = { left = icons.left_comp },
                color = {
                    bg = colors.green,
                    fg = colors.white,
                    gui = "bold"
                }
            },
            {
                bared,
                -- separator = { left = icons.left_comp },
                separator = "",
                padding = { left = 0 },
                color = {
                    bg = colors.blue,
                    fg = colors.blue,
                    gui = "bold",
                }
            },

        },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},

    },
    tabline = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { require('tabline').tabline_buffers },
        lualine_x = { require('tabline').tabline_tabs },
        lualine_y = {},
        lualine_z = {
        },
    },
    winbar = {
        -- { status_line() },
    },
    inactive_winbar = {},
    extensions = {},
})

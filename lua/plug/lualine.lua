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
    darkgreen   = "#115511",
    yellow      = '#ECBE7B',
    dark        = "#2a2d2d",
    deepdark    = "#1a1d1d",
    lightdark   = "#2e2f2f",
    bg          = '#202328',
    fg          = '#bbc2cf',
    cyan        = '#008080',
    violet      = '#a9a1e1',
    blue        = '#51afef',
    darkblue    = '#081633',
    light_blue  = "#7FF1FF",
    magenta     = '#c678dd',
    gray1       = '#828997',
    gray2       = '#2c323c',
    gray3       = '#3e4452',
    brown       = "#715522",
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
    Modified = '柳',
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
    tabline = {
        b = { fg = colors.fg, bg = colors.gray3, gui = "bold" },
    },
}

-- 隐藏component
local function hide()
    return vim.fn.winwidth(0) > 80
end

-- 空符，用来添加分割控件
local function empty()
    return ""
end

-- 给状态栏两端添加一个分割
local function bared()
    return icons.Bar
end

-- 显示Logo
local function logoed()
    return icons.Logo
end

-- 合并显示行，列，百分比
local function stated()
    -- return "%c:%l %5p%%:%8([%l/%L%)]"
    return "%2c:℅ %2p%%%3l/%L☰"
end

-- 显示macro
local function register()
    local reg = vim.fn.reg_recording()
    if reg == "" then
        return ""
    end
    return "@" .. reg
end

-- 添加文件修改提示
local function modified()
    if vim.bo.modified then
        return icons.Changed
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

-- 显示加载的lsp client
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

-- 显示查询结果
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

---------------------------------------------------------------------
-- lualine 设置
---------------------------------------------------------------------
require("lualine").setup({
    options = {
        theme = theme,
        icons_enabled = true,
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
                modified,
                separator = { left = icons.left_comp },
                color = {
                    bg = colors.red2,
                    fg = colors.white,
                    gui = "bold"
                }
            },
            {
                empty,
                padding = 0,
                separator = { left = icons.left_comp },
                draw_empty = true,
                -- color = { bg = colors.white, fg = colors.white, gui = "bold" },
                color = { bg = colors.gray2, fg = colors.gray2, gui = "bold" },
            },
        },
        lualine_x = {
            {
                "diff",
                separator = { left = icons.left_comp },
                symbols = { added = icons.Added, modified = icons.Modified, removed = icons.Removed },
            },
            {
                "branch",
                separator = { left = icons.left_comp },
            },
            {
                "diagnostics",
                separator = { left = icons.left_comp },
                source = { "nvim_diagnostic" },
                sections = { "error" },
                symbols = { error = icons.Error, warn = icons.Warn, info = icons.Info, hint = icons.Hint },
                diagnostics_color = { error = { bg = colors.bg, fg = colors.red, gui = "bold" } },
            },
            {
                "diagnostics",
                separator = { left = icons.left_comp },
                source = { "nvim_diagnostic" },
                sections = { "warn" },
                symbols = { error = icons.Error, warn = icons.Warn, info = icons.Info, hint = icons.Hint },
                diagnostics_color = { warn = { fg = colors.yellow, bg = colors.bg, gui = "bold" } },
            },
            {
                "diagnostics",
                separator = { left = icons.left_comp },
                source = { "nvim_diagnostic" },
                sections = { "info" },
                symbols = { error = icons.Error, warn = icons.Warn, info = icons.Info, hint = icons.Hint },
                diagnostics_color = { info = { fg = colors.blue, bg = colors.bg, gui = "bold" } },
            },
            {
                "diagnostics",
                separator = { left = icons.left_comp },
                source = { "nvim_diagnostic" },
                symbols = { error = icons.Error, warn = icons.Warn, info = icons.Info, hint = icons.Hint },
                sections = { "hint" },
                diagnostics_color = { hint = { fg = colors.light_blue, bg = colors.bg, gui = "bold" } },
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
                register,
                separator = { left = icons.left_comp },
                color = {
                    bg = colors.fg,
                    fg = colors.gray2,
                    gui = "bold"
                }
            },
            {
                search_result,
                padding = 1,
                separator = { left = icons.left_comp },
                color = {
                    bg = colors.gray3,
                    fg = colors.orange2,
                    gui = "bold"
                },
            },
            {
                "encoding",
                separator = { left = icons.left_comp },
                cond = hide,
                color = {
                    bg = colors.darkgreen,
                    fg = colors.fg,
                    gui = "bold"
                },
            },
            {
                "filetype",
                separator = { left = icons.left_comp },
                color = {
                    bg = colors.bg,
                    fg = colors.cyan,
                    gui = "bold"
                },
            },
            {
                lsp_client,
                separator = { left = icons.left_comp },
                color = {
                    bg = colors.gray3,
                    fg = colors.violet,
                    gui = "bold"
                },
                icon = icons.Lsp,
            },
            {
                stated,
                separator = { left = icons.left_comp },
                padding = { left = 1, right = 1 },
                color = {
                    bg = colors.brown,
                    fg = colors.white,
                    gui = "bold"
                }
            },

        },
        lualine_y = {

        },
        lualine_z = {
            {
                "fileformat",
                color = {
                    bg = colors.darkblue,
                    fg = colors.white,
                    gui = "bold"
                },
            },

            {
                bared,
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
    },
    inactive_winbar = {},
    extensions = {},
})

---------------------------------------------------------------------
-- End Of File
---------------------------------------------------------------------

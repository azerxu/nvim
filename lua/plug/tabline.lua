local ok, tabline = pcall(require, "tabline")
if not ok then
    vim.notify_once("tabline.lua load plugin:tabline failed")
end

tabline.setup({
    -- Defaults configuration options
    enable = true,
    options = {
        -- If lualine is installed tabline will use separators configured in lualine by default.
        -- These options can be used to override those settings.
        section_separators = { "", "" }, -- 分隔符
        component_separators = { "", "" }, -- 空间分割符
        max_bufferline_percent = 86,         -- set to nil by default, and it uses vim.o.columns * 2/3
        show_tabs_always = true,             -- this shows tabs only when there are more than one tab or if the first tab is named
        show_devicons = true,                -- this shows devicons in buffer section
        show_bufnr = true,                   -- this appends [bufnr] to buffer section,
        show_filename_only = true,           -- shows base filename only instead of relative path in filename
        modified_icon = "+",                 -- change the default modified icon
        modified_italic = true,              -- set to true by default; this determines whether the filename turns italic if modified
        show_tabs_only = false,              -- this shows only tabs instead of tabs + buffers
    },
})

vim.cmd([[
        set guioptions-=e " Use showtabline in gui vim
        set sessionoptions+=tabpages,globals " store tabpages and globals in session
]])

-------------------------------------------------------------------------------
-- 设置快捷键
-------------------------------------------------------------------------------
function BUFGO(index)
    local buf = tabline.buffers[tabline.mod(tonumber(index), #tabline.buffers)]
    if buf ~= nil then
        vim.cmd("silent! buffer " .. buf.bufnr)
    end
end

vim.keymap.set("n", "<A-1>", "<cmd>lua BUFGO(1)<CR>", { desc = "go buffer 1" })
vim.keymap.set("n", "<A-2>", "<cmd>lua BUFGO(2)<CR>", { desc = "go buffer 2" })
vim.keymap.set("n", "<A-3>", "<cmd>lua BUFGO(3)<CR>", { desc = "go buffer 3" })
vim.keymap.set("n", "<A-4>", "<cmd>lua BUFGO(4)<CR>", { desc = "go buffer 4" })
vim.keymap.set("n", "<A-5>", "<cmd>lua BUFGO(5)<CR>", { desc = "go buffer 5" })
vim.keymap.set("n", "<A-6>", "<cmd>lua BUFGO(6)<CR>", { desc = "go buffer 6" })
vim.keymap.set("n", "<A-7>", "<cmd>lua BUFGO(7)<CR>", { desc = "go buffer 7" })
vim.keymap.set("n", "<A-8>", "<cmd>lua BUFGO(8)<CR>", { desc = "go buffer 8" })
vim.keymap.set("n", "<A-9>", "<cmd>lua BUFGO(9)<CR>", { desc = "go buffer 9" })

-------------------------------------------------------------------------------
-- End Of File
-------------------------------------------------------------------------------

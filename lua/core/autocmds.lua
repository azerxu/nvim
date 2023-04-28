local augroup = vim.api.nvim_create_augroup -- create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- create autocommand

-- Remove whitespace on save
autocmd("BufWritePre", {
    pattern = "",
    command = ":%s/\\s\\+$//e",
})

-- Don't auto commenting new lines
autocmd("BufEnter", {
    pattern = "",
    command = "set fo-=c fo-=r fo-=o",
})

-- set colorcolumn
autocmd("BufEnter", {
    pattern = "",
    command = ":set colorcolumn=100",
})

-- Disable line length marker
augroup("setLineLength", { clear = true })
autocmd("Filetype", {
    group = "setLineLength",
    pattern = { "text", "markdown", "html", "xhtml", "javascript", "typescript", "yaml", "lua" },
    command = "setlocal cc=0",
})

-- Set indenation to 4 spaces
augroup("setIndent", { clear = true })
autocmd("Filetype", {
    group = "setIndent",
    pattern = { "text", "markdown", "html", "xhtml", "javascript", "typescript", "yaml", "lua" },
    command = "setlocal shiftwidth=4 tabstop=4",
})

-- automatic reloading init file
autocmd("BufWritePost", {
    pattern = "init.lua",
    command = ":source %",
})

-- Display a message when the current file is not in utf-8 format.
-- Note that we need to use `unsilent` command here because of this issue:
-- https://github.com/vim/vim/issues/4379
augroup("nonUTF8", { clear = true })
autocmd("BufRead", {
    pattern = "*",
    group = "nonUTF8",
    callback = function()
        if vim.bo.fileencoding ~= "utf-8" then
            vim.notify("File not in UTF-8 format!", vim.log.levels.WARN, { title = "nvim-config" })
        end
    end,
})

-- highlight yanked region, see `:h lua-highlight`
augroup("hlYank", { clear = true })
autocmd("TextYankPost", {
    pattern = "*",
    group = "hlYank",
    -- command = 'silent! lua vim.highlight.on_yank { higroup = "IncSearch", timeout = 500 }',
    -- command = "silent! lua vim.highlight.on_yank { timeout = 400 }",
    callback = function()
        vim.highlight.on_yank({ timeout = 400 })
    end,
})

-- auto create dir when saving file
augroup("autoDir", { clear = true })
autocmd("BufWritePre", {
    pattern = "*",
    callback = function(ctx)
        local dir = vim.fn.fnamemodify(ctx.file, ":p:h")
        local res = vim.fn.isdirectory(dir)
        if res == 0 then
            vim.fn.mkdir(dir, "p")
        end
    end,
})

--------------------------------------------------------------
-- json with comment file config
--------------------------------------------------------------

-- 处理带有注释的json文件为jsonc文件
augroup("jsoncFtDetect", { clear = true })
autocmd({ "BufNewFile", "BufRead" }, {
    group = "jsoncFtDetect",
    pattern = "*config.json",
    command = "setlocal filetype=jsonc",
})
autocmd({ "BufNewFile", "BufRead" }, {
    group = "jsoncFtDetect",
    pattern = "*.cjson",
    command = "setlocal filetype=jsonc",
})
autocmd({ "BufNewFile", "BufRead" }, {
    group = "jsoncFtDetect",
    pattern = "*.cjsn",
    command = "setlocal filetype=jsonc",
})
autocmd({ "BufNewFile", "BufRead" }, {
    group = "jsoncFtDetect",
    pattern = "coc-settings.json", -- for coc settings config file
    command = "setlocal filetype=jsonc",
})
autocmd({ "BufNewFile", "BufRead" }, {
    group = "jsoncFtDetect",
    pattern = "*/v2ray/confs/*.json",
    command = "setlocal filetype=jsonc",
})
autocmd({ "BufNewFile", "BufRead" }, {
    group = "jsoncFtDetect",
    pattern = "coffeelint.json",
    command = "setlocal filetype=jsonc",
})

-- set json commenting
autocmd("Filetype", {
    pattern = "json",
    -- command = "syntax match Comment +\/\/.\+$+",
    command = "syntax match Comment '//.*'",
})

vim.cmd([[
    autocmd FileType json syntax match Comment +\/\/.\+$+
]])

--------------------------------------------------------------
-- End of File
--------------------------------------------------------------

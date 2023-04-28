vim.opt.termguicolors = true      -- set termguicolors to enable highlight groups
vim.opt.number = true             -- 设置行号
vim.opt.relativenumber = true     -- 显示相对行号
vim.opt.cursorline = true         -- 光标所在行高亮
vim.opt.smartindent = true        -- 开启新行时自动缩进
vim.opt.autowrite = true          -- 自动写文件
vim.opt.autoread = true           -- 自动读文件
vim.opt.laststatus = 2            -- 显示状态栏和标题栏
vim.opt.showcmd = true
vim.wo.colorcolumn = 100          -- 设置边界条长度
vim.opt.hlsearch = false          -- 不高亮前次的搜索
vim.opt.wrap = false              -- 不换行
vim.opt.swapfile = false          -- 不产生交换文件
vim.opt.writebackup = false       --不需要备份文件

vim.opt.clipboard = "unnamedplus" -- 拷贝信息可以传递到系统

----------------------------------------------------
-- tab setting
----------------------------------------------------
vim.opt.expandtab = true -- 转换tab为space
vim.opt.softtabstop = 4
vim.opt.tabstop = 4      -- 屏幕显示tab的长度
vim.opt.shiftwidth = 4   --  << and >> 的长度
vim.opt.shiftround = true


-- indent
vim.opt.autoindent = true
vim.opt.smartindent = true

-- search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- case
vim.opt.ignorecase = true -- 搜索时忽略大小写
vim.opt.smartcase = true

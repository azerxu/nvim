vim.g.encoding = "utf-8"

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-----------------------------------------------------------
-- core setting
-----------------------------------------------------------
require("plugins")       -- 有这一句才能有PackerInstall
require("core.options")  -- 设置vim.opt参数
require("core.keymap")   -- 设置快捷键
require("core.autocmds") -- 设置自动运行命令

-------------------------------------------------------------
-- Plugins setting
-------------------------------------------------------------
require("plug.colorscheme") -- neovim 界面风格设置
require("plug.notify")      -- Beautiful Notification
require("plug.comment")     -- Comment.nvim
require("plug.telescope")   -- search file
require("plug.nvimtree")    -- 文件栏，替换nerdTree
require("plug.lualine")     -- 状态栏
require("plug.treesitter")  -- 解析器
require("plug.orgmode")     -- nvim org-mode
require("plug.debug")       -- delve debug
require("plug.git")         -- setting git
require("plug.trouble")     -- 显示 diagnostics
require("plug.tabline")     -- 使用tabline
require("plug.whickey")     -- vim short key helpers
require("plug.toggleterm")  -- 加强版Term
-- require("plug.formatter")      -- format on save
-- require("plug.indent-blankline") -- 显示indent

-----------------------------------------------------------
-- language server setting
-----------------------------------------------------------
require("lsp.mason")       -- lsp 包管理
require("lsp.lspkind")     -- 设置自动补全的图标
require("lsp.config")      -- 为每个buffer 设置 LspAttach_keyMap
require("lsp.format")      -- 为每个buffer 设置 LspAttach_formatOnSave
require("lsp.hints")       -- 为每个buffer 设置 LspAttach_inlayhints
require("lsp.virtualtext") -- 为每个buffer 设置 LspAttach_virtualText
require("lsp.dochl")       -- 为每个buffer 设置LspAttach_documentHighlight
require("lsp.cmp")         -- nvim-cmp 自动补全
-- require("lsp.nulls") -- for autoformat

-----------------------------------------------------------
-- Language setting
-----------------------------------------------------------
require("lang.go")      -- for go lang settings
require("lang.gopls")   -- for go lang
require("lang.luals")   -- for lua
require("lang.pyright") -- for python
require("lang.pylsp")   -- for python
require("lang.bashls")  -- for bash
require("lang.jsonls")  -- for json


-----------------------------------------------------------
-- end of this inin.lua
-----------------------------------------------------------

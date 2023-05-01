-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

---------------------------------------------------------------
-- 功能键自定义
---------------------------------------------------------------

-- 设置<F2>为paste模式快捷键
-- map('n', '<F2>', ':set invpaste paste?<CR>')
vim.opt.pastetoggle = "<F2>"

map("n", "<F3>", ":NvimTreeToggle<CR>") -- 目录树开关
map("n", "<F4>", ":Vista<CR>")          -- tagbar 替代
map("n", "<F5>", ":DiffviewOpen<CR>")   -- 打开显示修改
map("n", "<F6>", ":DiffviewClose<CR>")  -- 关闭Diff

-- nvim-dap key mappings
map("n", "<F7>", [[:lua require'dap'.continue()<CR>]])          -- Press F7 to debug
map("n", "<F8>", [[:lua require'dap'.toggle_breakpoint()<CR>]]) -- Press F8 to 设置断点
map("n", "<F9>", [[:lua require'dapui'.toggle()<CR>]])          -- Press F9 显示debug界面

---------------------------------------------------------------
-- 自定义快捷键设置
---------------------------------------------------------------
vim.g.mapleader = " "      -- global mapleader
vim.g.maplocalleader = " " -- local mapleader

-- swith buffer
map("n", "<leader>n", ":bnext<CR>")             -- 切换到下一个buffer
map("n", "<leader>p", ":bprevious<CR>")         -- 切换到上一个buffer
map("n", "<leader>d", ":bd!<CR>")               -- 删除当前buffer

map("i", "<A-;>", "<Esc>")                      -- 将alt+; 映射到 Esc
map("n", "<A-w>", ":w<CR>")                     -- alt+w 保存文件
map("n", "<A-q>", ":Bd<CR>")                    -- alt+q 关闭buffer
map("t", "<A-q>", "<C-\\><C-N>:q!<CR>")         -- alt+q 关闭Term窗口
map("n", "<A-S-q>", ":q<CR>")                   -- alt+Q 关闭窗口
map("n", "<leader>q", ":qa!<CR>")               -- cloase all windows and exit
map("n", "<leader>s", ":so %<CR>")              -- reload config file

map("n", "<A-->", ":isplit<CR>")                -- alt+- 水平分割窗口
map("n", "<A-|>", ":vsplit<CR>")                -- alt+v 垂直分割窗口

map("n", "<A-j>", "<C-w>j")                     -- alt+j设置为切换到上一个窗口
map("n", "<A-k>", "<C-w>k")                     -- alt+k设置为切换到下一个窗口
map("n", "<A-l>", "<C-w>l")                     -- alt+l设置为切换到左边窗口
map("n", "<A-h>", "<C-w>h")                     -- alt+h设置为切换到右边窗口

map("t", "<A-j>", "<C-\\><C-N><C-W>j")          -- alt+j设置为切换到上一个Term窗口
map("t", "<A-k>", "<C-\\><C-N><C-w>k")          -- alt+k设置为切换到下一个Term窗口
map("t", "<A-l>", "<C-\\><C-N><C-w>l")          -- alt+l设置为切换到左边Term窗口
map("t", "<A-h>", "<C-\\><C-N><C-w>h")          -- alt+h设置为切换到右边Term窗口

map("i", "<A-j>", "<C-o>j")                     -- insert mode下进入下一行
map("i", "<A-k>", "<C-o>k")                     -- insert mode下进入下一行
map("i", "<A-l>", "<C-o>l")                     -- insert mode下左移一个字符
map("i", "<A-h>", "<C-o>h")                     -- insert mode下右移一个字符
map("i", "<A-f>", "<C-o>w")                     -- insert mode下前进一个单词
map("i", "<A-b>", "<C-o>b")                     -- insert mode下后退一个单词

map("i", "<A-S-p>", "<C-o>p")                   -- inser mode下粘贴

map("n", "<A-o>", ":Commentary<CR>")            -- alt+o注释或反注释
map("v", "<A-o>", ":Commentary<CR>")            -- alt+o注释或反注释block
map("n", "<A-z>", "<Plug>(zoom-toggle)")        -- zoom panel like tmux

map("n", "<A-\\>", "hdiw")                      -- 回退删除一个空白字符/单词
map("i", "<A-\\>", "<C-o>h<C-o>diw")            -- 回退删除一个空白字符/单词
map("n", "<A-d>", "daw")                        -- 向前删除一个单词
map("i", "<A-d>", "<C-o>daw")                   -- 向前删除一个单词
map("n", "<A-BS>", "bdw")                       -- 删除当前光标前的所有字符
map("i", "<A-BS>", "<C-w>")                     -- 删除当前光标前的所有字符
map("n", "<C-k>", "<S-D>")                      -- 删除当期光标后的所有字符
map("i", "<C-k>", "<C-o><S-D>")                 -- 删除当期光标后的所有字符
map("n", "<A-u>", "u")                          -- undo
map("i", "<A-u>", "<C-o>u")                     -- undo

map("n", "<C-a>", "<C-o>0")                     -- 回到首字符
map("i", "<C-a>", "<C-o>0")                     -- 回到首字符
map("n", "<C-e>", "$")                          -- 到尾字符
map("i", "<C-e>", "<C-o>$")                     -- 到尾字符

map("n", "<A-S-t>", ":vnew term://bash<CR>")    -- 开启一个terminal
map("t", "<Esc>", "<C-\\><C-n>")                -- exit terminal

map("n", "<A-+>", ":tabnew<CR>")                -- 新建一个tab
map("n", "<A-=>", ":tabclose<CR>")              -- 新建一个tab
map("n", "<A-]>", ":tabnext<CR>")               -- 下一个tab
map("n", "<A-[>", ":tabprevious<CR>")           -- 前一个tab

map("n", "<A-c>", "i<C-o>e<C-o>b<C-o>~<Esc>el") -- reverse case
map("i", "<A-c>", "<C-o>e<C-o>b<C-o>~<Esc>ea")  -- reverse case

map("n", "<A-S-u>", "gUaWel")                   -- upper case
map("i", "<A-S-u>", "<C-o>gUaW<C-o>e<C-o>l")    -- upper case
map("n", "<A-S-l>", "guaWel")                   -- lower case
map("i", "<A-S-l>", "<C-o>guaW<C-o>e<C-o>l")    -- lower case

map("i", "<C-d>", "<C-o>x")                     -- delete a forward character
map("i", "<C-S-d>", "<C-o>X")                   -- delete a back character

-- resize with arrows
map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")


-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")

-- Move text up and down
map("n", "<S-j>", "<Esc>:m .+1<CR>==gi")
map("n", "<S-k>", "<Esc>:m .-2<CR>==gi")

-- Move text up and down
map("v", "<S-j>", ":m .+1<CR>==")
map("v", "<S-k>", ":m .-2<CR>==")
map("v", "p", '"_dP')

-- Visual Block --
-- Move text up and down
-- map("x", "J", ":move '>+1<CR>gv-gv")
-- map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "<S-j>", ":move '>+1<CR>gv-gv")
map("x", "<S-k>", ":move '<-2<CR>gv-gv")

---------------------------------------------------------------
-- End OF settings
---------------------------------------------------------------

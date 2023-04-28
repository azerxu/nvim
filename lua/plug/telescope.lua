local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = 'find files' })                       -- 查找工作目录
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = 'live grep' })                         -- pattern查找工作目录
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = 'buffers' })                             -- 查找打开的文件
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = 'help tags' })                         -- 搜索帮助
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = 'diagnostics' })                     -- 搜索诊断信息
vim.keymap.set("n", "<leader>fs", builtin.current_buffer_fuzzy_find, { desc = 'buffer fuzzy find' }) -- 当前buffer模糊查找
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = 'oldfiles' })                           -- 搜索最近访问的文件
vim.keymap.set("n", "<leader>fn", '<cmd>Telescope notify<CR>', { desc = 'notify' })                  -- 搜索notify


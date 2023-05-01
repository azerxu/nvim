local notify = require("notify")
notify.setup({
    stages = "fade_in_slide_out",
    -- timeout = 1500,
    background_color = "#2E3440",
})

vim.notify = notify

require("telescope").load_extension("notify")
vim.keymap.set("n", "<leader>fn", '<cmd>Telescope notify<CR>', { desc = 'notify' }) -- 搜索notify

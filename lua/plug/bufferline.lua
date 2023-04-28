require("bufferline").setup({
    options = {
        mode = "buffers",
        offsets = {
            { filetype = "NvimTree" },
        },
    },
    highlights = {
        buffer_selected = {
            italic = true
        },
        indicator_selected = {
            fg = { attribute = 'fg', highlight = 'Function' },
            italic = false
        }
    }
})

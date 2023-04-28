-- for indent-line
-- vim.opt.list = true
-- vim.opt.listchars = { eol = "↲", tab = "▸ ", trail = "·" }
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"

-- vim.cmd [[ highlight IndentBlankLineIndent1 guibg=#2f2f2f gui=nocombine ]]
-- vim.cmd [[ highlight IndentBlankLineIndent1 guibg=#2a2a2a gui=nocombine ]]

require('indent_blankline').setup({
    char = '▏ ',
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    use_treesitter = true,
    show_current_context = true,
    show_end_of_line = false,
    -- show_current_context_start = true,
    -- space_char_blankline = " ",
    -- char_highlight_list = {
    --     "IndentBlankLineIndent1",
    --     "IndentBlankLineIndent2",
    -- },
    -- space_char_highlight_list = {
    --     "IndentBlankLineIndent1",
    --     "IndentBlankLineIndent2",
    -- },
})

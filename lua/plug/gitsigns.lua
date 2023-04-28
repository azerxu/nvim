require("gitsigns").setup({
    signs = {
        add = { text = '▎' },        -- signs for add lines
        change = { text = '▎' },     -- sings for modified lines
        delete = { text = '➤' },     -- sings for delete lines
        topdelete = { text = '➤' },  -- This sign shows if the first lines of the file have been deleted.
        changedelete = { text = '▎' }, -- Sign for modified lines that occupy the same space as a deleted line.
    }
})

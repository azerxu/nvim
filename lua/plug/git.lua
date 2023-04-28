--------------------------------------------------------------
-- setting gitsings
-- 显示文件改变
--------------------------------------------------------------
require("gitsigns").setup({
    signs = {
        add = { text = '▎' },        -- signs for add lines
        change = { text = '▎' },     -- sings for modified lines
        delete = { text = '➤' },     -- sings for delete lines
        topdelete = { text = '➤' },  -- This sign shows if the first lines of the file have been deleted.
        changedelete = { text = '▎' }, -- Sign for modified lines that occupy the same space as a deleted line.
    }
})

--------------------------------------------------------------
-- setting diffview
-- 差异文件比较
--------------------------------------------------------------
require("diffview").setup()

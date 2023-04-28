-- change gcA to alt+;
-- add comment at end of line
require("Comment").setup({
	extra = { eol = "<A-;>" },
	toggler = {
		---Line-comment toggle keymap
		-- line = "<A-o>",
		---Block-comment toggle keymap
		-- block = "gbc",
	},
})

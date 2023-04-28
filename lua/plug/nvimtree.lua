require("nvim-tree").setup({
	sort_by = "case_sensitive",
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
	-- open_on_setup = true,
	-- ignore_buffer_on_setup = true,
})

-- local map = vim.api.nvim_set_keymap

-- map the key n to run the command :NvimTreeToggle
-- map('n', 'n', [[:NvimTreeToggle<CR>]], {})

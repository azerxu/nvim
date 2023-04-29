local ok, nulls = pcall(require, "null-ls")
if not ok then
    vim.notify("nulls.lua load null-ls failed!")
    return
end

local sources = {
    -------------------------------------------
    -- Lua mode
    -------------------------------------------
    -- nulls.builtins.formatting.stylua,

    -------------------------------------------
    -- Python mode
    -------------------------------------------
    nulls.builtins.formatting.autopep8,
    nulls.builtins.formatting.black.with({ extra_args = { "--line-length=120" } }),
    nulls.builtins.formatting.isort,
    -- nulls.builtins.formatting.yapf,

    nulls.builtins.diagnostics.mypy,
    -- nulls.builtins.diagnostics.flake8,
    -- nulls.builtins.diagnostics.pylint,
    -- nulls.builtins.diagnostics.pydocstyle,
    -- nulls.builtins.diagnostics.pycodestyle,

    -------------------------------------------
    -- Json mode
    -------------------------------------------
    nulls.builtins.diagnostics.jsonlint,

    -------------------------------------------
    -- JavaScript mode
    -------------------------------------------
    nulls.builtins.diagnostics.eslint,

    -- nulls.builtins.completion.spell,

    -- git mode
    nulls.builtins.code_actions.gitsigns,
}

nulls.setup({
    sources = sources,
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})

-- nulls.register(sources)

-- local no_really = {
-- 	method = nulls.methods.DIAGNOSTICS,
-- 	filetypes = { "markdown", "text" },
-- 	generator = {
-- 		fn = function(params)
-- 			local diagnostics = {}
-- 			-- sources have access to a params object
-- 			-- containing info about the current file and editor states
-- 			for i, line in ipairs(params.content) do
-- 				local col, end_col = line:find("really")
-- 				if col and end_col then
-- 					-- null-ls fills in undefined positions
-- 					-- and convers source diagnostics into the required format
-- 					table.insert(diagnostics, {
-- 						row = i,
-- 						col = col,
-- 						end_col = end_col + 1,
-- 						source = "no-really",
-- 						message = "Don't use 'really!'",
-- 						severity = vim.diagnostic.severity.WARN,
-- 					})
-- 				end
-- 			end
-- 			return diagnostics
-- 		end,
-- 	},
-- }

-- nulls.register(no_really)

-- local helpers = require("null-ls.helpers")

-- local markdownlint = {
-- 	method = nulls.methods.DIAGNOSTICS,
-- 	filetypes = { "markdown" },
-- 	-- null_ls.generator creates an async source
-- 	-- that spawns the command with the given argument and options
-- 	generator = nulls.generator({
-- 		command = "markdownlint",
-- 		args = { "--stdin" },
-- 		to_stdin = true,
-- 		from_stderr = true,
-- 		-- choose an output format (raw, json, or line)
-- 		format = "line",
-- 		check_exit_code = function(code, stderr)
-- 			local success = code <= 1

-- 			if not success then
-- 				-- can be noisy for things that run often (e.g. diagnostics),
-- 				-- but can be useful for things thaat run on demand (e.g. formating)
-- 				print(stderr)
-- 			end
-- 			return success
-- 		end,
-- 		-- use helpers to parse the output from string matches,
-- 		-- or parse it manually with a funtion
-- 		on_output = helpers.diagnostics.from_patterns({
-- 			{
-- 				patten = [[:(%d+):(%d+)[%w-/]+ (.*)]],
-- 				groups = { "raw", "col", "message" },
-- 			},
-- 			{
-- 				patten = [[:(%d+) [%w-/]+ (.*)]],
-- 				groups = { "raw", "message" },
-- 			},
-- 		}),
-- 	}),
-- }

-- nulls.register(markdownlint)

-- vim.lsp.buf.format({ timeout_ms = 1000 })

-- local gitsigns = nulls.builtins.code_actions.gitsigns.with({
-- 	config = {
-- 		filter_actions = function(title)
-- 			return title.lower():match("blame") == nil -- filter out blame action
-- 		end,
-- 	},
-- })
-- })
-- })
-- })

-- Install Packer automatically if it's not installed(Bootstraping)
-- Hint: string concatenation is done by `..`
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer()

-- Reload configurations if we modify plugins.lua
-- Hint
--     <afile> - replaced with the filename of the buffer being manipulated
vim.cmd([[
    augroup packer_user_config
        autocmd!
        " autocmd BufWritePost plugins.lua source <afile> | PackerSync
        autocmd BufWritePost plugins.lua source <afile>
    augroup end
]])

-- Install plugins here - `use ...`
-- Packer.nvim hints
--     after = string or list,           -- Specifies plugins to load before this plugin. See "sequencing" below
--     config = string or function,      -- Specifies code to run after this plugin is loaded
--     requires = string or list,        -- Specifies plugin dependencies. See "dependencies".
--     ft = string or list,              -- Specifies filetypes which load this plugin.
--     run = string, function, or table, -- Specify operations to be run after successful installs/updates of a plugin

vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
    -- Packer can manage itself
    use({ "wbthomason/packer.nvim" })

    ---------------------------------------
    -- NOTE: PUT YOUR THIRD PLUGIN HERE --
    ---------------------------------------

    use({
        -- 安装nvim tree 文件栏
        "nvim-tree/nvim-tree.lua",
        requires = {
            { "nvim-tree/nvim-web-devicons" },
        },
    })

    use({ -- vim panel 放大缩小, <C-w>m
        "dhruvasagar/vim-zoom",
    })

    use({ -- 配对括号
        "jiangmiao/auto-pairs",
    })

    use({ -- 标签/字符替换
        "machakann/vim-sandwich",
    })

    use({ -- 配色方案
        "tanvirtin/monokai.nvim",
    })

    use({ -- 漂亮的notify
        "rcarriga/nvim-notify",
    })

    use({
        -- lua版的airline
        "nvim-lualine/lualine.nvim",
        requires = {
            { "nvim-tree/nvim-web-devicons" },
        },
    })

    use({ -- tag bar learns from LSP servers
        "liuchengxu/vista.vim",
    })

    use({ -- 读写没有权限的文件
        "lambdalisue/suda.vim",
    })

    use({
        -- tabline
        "kdheepak/tabline.nvim",
        requires = {
            { "nvim-lualine/lualine.nvim" },
            { "nvim-tree/nvim-web-devicons" },
        },
    })

    use {
        'kosayoda/nvim-lightbulb',
        requires = 'antoinemadec/FixCursorHold.nvim',
    }

    use({
        -- 替代fzf
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        requires = { "nvim-lua/plenary.nvim" },
    })

    use({ -- 更强的注释插件 for neovim, 可以在行尾添加注释
        "numToStr/Comment.nvim",
    })

    use({ -- 注释代码
        "tpope/vim-commentary",
    })

    use({
        -- nvim-treesitter
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    })

    use({
        -- bufferline
        "akinsho/bufferline.nvim",
        tag = "v3.*",
        requires = "nvim-tree/nvim-web-devicons",
    })

    use({ -- nvim orgmode
        "nvim-orgmode/orgmode",
    })

    use({ -- vim table mode
        "dhruvasagar/vim-table-mode",
    })

    use({
        -- meson
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        run = ":MasonUpdate", -- :MasonUpdate updates registry contents
    })

    -- vim-cmp
    use({ "neovim/nvim-lspconfig" })
    use({ "hrsh7th/nvim-cmp" })
    use({ "hrsh7th/cmp-nvim-lsp", requires = "hrsh7th/nvim-cmp" })
    use({ "hrsh7th/cmp-nvim-lua", requires = "hrsh7th/nvim-cmp" })
    use({ "hrsh7th/cmp-buffer", requires = "hrsh7th/nvim-cmp" })                  -- buffer auto-completion
    use({ "hrsh7th/cmp-nvim-lsp-signature-help", requires = "hrsh7th/nvim-cmp" }) -- param enhanced
    use({ "hrsh7th/cmp-path", requires = "hrsh7th/nvim-cmp" })                    -- path auto-completion
    use({ "hrsh7th/cmp-cmdline", requires = "hrsh7th/nvim-cmp" })                 -- cmdline auto-completion
    use({ "petertriho/cmp-git", requires = "nvim-lua/plenary.nvim" })             -- git auto-completion
    use({
        -- LuaSnip
        "L3MON4D3/LuaSnip",
        tag = "v1.2.*",
        run = "make install_jsregexp", -- install jsregexp optional
    })

    use({ "saadparwaiz1/cmp_luasnip" })

    use({ "rafamadriz/friendly-snippets" })

    use({
        -- null-ls
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    })

    use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" }) -- diffview

    use({
        -- gitsigns
        "lewis6991/gitsigns.nvim",
        tag = "release", -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
    })

    use({
        -- nvim dap Dap for Debug
        "mfussenegger/nvim-dap",
        tag = "0.9.*",
    })

    use({
        "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" },
    })

    use({
        "folke/which-key.nvim",
    })

    use({ -- icons for lspconfig
        "onsails/lspkind.nvim",
    })

    use({
        -- show preety list for diagnostics,reference, telescope
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
    })

    use {
        "SmiteshP/nvim-navbuddy",
        requires = {
            "neovim/nvim-lspconfig",
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim",
            "numToStr/Comment.nvim",        -- Optional
            "nvim-telescope/telescope.nvim" -- Optional
        }
    }

    use {
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig"
    }

    use { 'lukas-reineke/indent-blankline.nvim' }

    use { 'nvim-treesitter/nvim-treesitter-textobjects' }

    use { "akinsho/toggleterm.nvim", tag = '*' }


    use { 'tpope/vim-fugitive' }

    use { 'moll/vim-bbye' }

    use { 'HiPhish/nvim-ts-rainbow2' }

    use({
        'lvimuser/lsp-inlayhints.nvim',
    })

    use({ 'jubnzv/virtual-types.nvim' })

    use({
        "ray-x/go.nvim",
        requires = {
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        }
    })

    use {
        "ray-x/lsp_signature.nvim",
    }
    ---------------------------------------
    -- python plugins
    ---------------------------------------

    use({ "mhartington/formatter.nvim" })

    use({ "mfussenegger/nvim-lint" })


    ---------------------------------------
    -- END OF PUT YOUR THIRD PLUGIN HERE --
    ---------------------------------------

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)

---------------------------------------
-- end of plugins
---------------------------------------

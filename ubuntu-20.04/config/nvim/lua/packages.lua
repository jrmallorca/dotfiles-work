-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

-- Packages
local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'     -- Package manager
  use 'Pocco81/TrueZen.nvim'       -- Better UI
  use {                            -- Display git signs
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }
  use {                            -- Fuzzy finder
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }
  use 'neovim/nvim-lspconfig'      -- Configurations for built-in LSP client
  use 'hrsh7th/nvim-compe'         -- Autocompletion plugin
  use 'L3MON4D3/LuaSnip'           -- Snippets plugin
  use 'windwp/nvim-autopairs'      -- Autopairs plugin
  use 'ggandor/lightspeed.nvim'    -- 2 character search
  use 'winston0410/commented.nvim' -- Comment blocks of code
  -- Neovim org mode (Notes and organisation)
  use {
    "vhyrro/neorg",
    requires = "nvim-lua/plenary.nvim",
  }
  use {                            -- Testing
    "rcarriga/vim-ultest",
    requires = {
      "vim-test/vim-test"
    },
    run = ":UpdateRemotePlugins"
  }
end)

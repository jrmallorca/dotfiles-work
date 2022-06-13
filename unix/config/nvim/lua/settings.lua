vim.opt.shell = "/bin/bash" -- Use bash for scripts

vim.o.hidden = true -- Hide buffer when abandoned instead of closing
                    -- Do not save when switching buffers

vim.o.updatetime = 250 -- Decrease update time

vim.wo.relativenumber = true -- Show relative line numbers
vim.wo.number = true         -- Show actual line numbers (where the cursor is)
vim.wo.signcolumn = 'yes'    -- Display sign column

vim.o.pastetoggle = "<F2>"      -- Toggle paste format via 'F2'
vim.o.clipboard = "unnamedplus" -- Yank to system clipboard

vim.o.expandtab = true -- Tabs become spaces
vim.bo.expandtab = true
vim.o.tabstop = 4      -- Tabs becomes 4 space width
vim.bo.tabstop = 4
vim.o.shiftwidth = 4   -- Indenting with '>' uses 4 space width
vim.bo.shiftwidth = 4

vim.wo.wrap = false       -- Don't wrap lines
vim.wo.breakindent = true -- Preserve indentation within wrapped lines
vim.o.autoindent = true   -- Copy indent from current line when starting new line
vim.bo.autoindent = true
vim.o.smartindent = true  -- Smart auto indentation
vim.bo.smartindent = true

vim.o.spelllang = "en_gb"

-- Case insensitive searching unless /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.hlsearch = false -- Don't highlight what has been searched
vim.o.incsearch = true -- Incrementally highlight what is currently being searched

vim.o.splitright = true -- New horizontal window is positioned to the right of current window
vim.o.splitbelow = true -- New vertical window is positioned below current window

vim.o.inccommand = "nosplit" -- Show effects of a command incrementally

vim.cmd [[set undofile]] -- Save undo history

vim.o.completeopt = 'menuone,noinsert' -- Completion

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)


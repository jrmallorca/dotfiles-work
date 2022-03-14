local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Remap space as leader key
map('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- \w = Save current file
-- \q = Quit
-- \x = Write all buffers and quit
map('n', '<Bslash>w', [[<Cmd>w<CR>]], opts)
map('n', '<Bslash>q', [[<Cmd>q<CR>]], opts)
map('n', '<Bslash>x', [[<Cmd>wqa<CR>]], opts)

-- TrueZen --
-- <Leader>1 = Ataraxis mode
-- <Leader>2 = Minimalist mode
-- <Leader>3 = Focus mode
-- <Leader>4 = Turn off TrueZen
map('n', '<Leader>1', [[<Cmd>TZAtaraxisOff<CR><Cmd>TZMinimalistOff<CR><Cmd>TZFocusOff<CR><Cmd>TZAtaraxisOn<CR>]], opts)
map('n', '<Leader>2', [[<Cmd>TZAtaraxisOff<CR><Cmd>TZMinimalistOff<CR><Cmd>TZFocusOff<CR><Cmd>TZMinimalistOn<CR>]], opts)
map('n', '<Leader>3', [[<Cmd>TZFocus<CR>]], opts)
map('n', '<Leader>4', [[<Cmd>TZAtaraxisOff<CR><Cmd>TZMinimalistOff<CR><Cmd>TZFocusOff<CR>]], opts)

-- Fuzzy finder --
-- \\  = Find files within current and child directories
-- \fb = Find open files in buffers
-- \/  = Find matching string within current and child directories
map('n', '<Bslash><Bslash>', [[<Cmd>Telescope find_files<CR>]], opts)
map('n', '<Bslash>fb', [[<Cmd>Telescope buffers<CR>]], opts)
map('n', '<Bslash>/', [[<Cmd>Telescope live_grep<CR>]], opts)

-- Lightspeed
-- Replace 's' with 'f'
map('n', 'f', [[<Plug>Lightspeed_s]], opts)
map('n', 'F', [[<Plug>Lightspeed_S]], opts)

-- Ultest
-- ]t         = Find next failed test, direction up
-- [t         = Find next failed test, direction down
-- <Leader>tt = Test everything
-- <Leader>tn = Test nearest to cursor
map('n', ']t', [[<Plug>(ultest-next-fail)]], opts)
map('n', '[t', [[<Plug>(ultest-prev-fail)]], opts)
map('n', '<Leader>tt', [[<Plug>(ultest-run-file)]], opts)
map('n', '<Leader>tn', [[<Plug>(ultest-run-nearest)]], opts)

-- Remap movement to be more friendly to text
vim.api.nvim_set_keymap('', 'j', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', 'k', 'gk', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '0', 'g0', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '$', 'g$', { noremap = true, silent = true })

vim.wo.scrolloff = 999  -- Set cursor line to always be in middle of window
vim.wo.wrap = true      -- Text makes a new line if over the length of window
vim.wo.linebreak = true -- Text will not break in the middle of a word when wrapping
vim.wo.spell = true     -- Indicate spelling errors

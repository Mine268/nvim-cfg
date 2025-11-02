-- define common options
local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}



-----------------
--- Tabs move ---
-----------------
vim.keymap.set('n', 'r', ':Tabnext<CR>', opts)
vim.keymap.set('n', 'q', ':Tabprevious<CR>', opts)

-----------------
--- Line move ---
-----------------
vim.keymap.set('n', '<S-J>', ':m .+1<CR>==', opts)
vim.keymap.set('n', '<S-K>', ':m .-2<CR>==', opts)
vim.keymap.set('v', '<S-J>', ":m '>+1<CR>gv=gv", opts)
vim.keymap.set('v', '<S-K>', ":m '<-2<CR>gv=gv", opts)

-----------------
-- Normal mode --
-----------------
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-----------------
-- Visual mode --
-----------------
-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-----------------
--- Telescope ---
-----------------
local telescopt_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescopt_builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', telescopt_builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', telescopt_builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', telescopt_builtin.help_tags, { desc = 'Telescope help tags' })

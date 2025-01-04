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
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

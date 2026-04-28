local opts = {
	noremap = true,
	silent = true,
}

-----------------
--- Tabs move ---
-----------------
vim.keymap.set('n', '<leader>[', ':tabprevious<CR>', vim.tbl_extend('force', opts, { desc = 'Previous tab' }))
vim.keymap.set('n', '<leader>]', ':tabnext<CR>',     vim.tbl_extend('force', opts, { desc = 'Next tab' }))

-----------------
--- Line move ---
-----------------
vim.keymap.set('n', '<S-J>', ':m .+1<CR>==',    vim.tbl_extend('force', opts, { desc = 'Move line down' }))
vim.keymap.set('n', '<S-K>', ':m .-2<CR>==',    vim.tbl_extend('force', opts, { desc = 'Move line up' }))
vim.keymap.set('v', '<S-J>', ":m '>+1<CR>gv=gv", vim.tbl_extend('force', opts, { desc = 'Move selection down' }))
vim.keymap.set('v', '<S-K>', ":m '<-2<CR>gv=gv", vim.tbl_extend('force', opts, { desc = 'Move selection up' }))

-----------------
-- Normal mode --
-----------------
vim.keymap.set('n', '<A-Up>',    ':resize -2<CR>',         vim.tbl_extend('force', opts, { desc = 'Shrink window height' }))
vim.keymap.set('n', '<A-Down>',  ':resize +2<CR>',         vim.tbl_extend('force', opts, { desc = 'Expand window height' }))
vim.keymap.set('n', '<A-Left>',  ':vertical resize -2<CR>', vim.tbl_extend('force', opts, { desc = 'Shrink window width' }))
vim.keymap.set('n', '<A-Right>', ':vertical resize +2<CR>', vim.tbl_extend('force', opts, { desc = 'Expand window width' }))

vim.keymap.set('n', '<A-h>', '<C-w>h', vim.tbl_extend('force', opts, { desc = 'Focus left window' }))
vim.keymap.set('n', '<A-j>', '<C-w>j', vim.tbl_extend('force', opts, { desc = 'Focus window below' }))
vim.keymap.set('n', '<A-k>', '<C-w>k', vim.tbl_extend('force', opts, { desc = 'Focus window above' }))
vim.keymap.set('n', '<A-l>', '<C-w>l', vim.tbl_extend('force', opts, { desc = 'Focus right window' }))

-----------------
-- Visual mode --
-----------------
vim.keymap.set('v', '<', '<gv', vim.tbl_extend('force', opts, { desc = 'Decrease indent, keep selection' }))
vim.keymap.set('v', '>', '>gv', vim.tbl_extend('force', opts, { desc = 'Increase indent, keep selection' }))

-----------------
--- Terminal  ---
-----------------
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]],     vim.tbl_extend('force', opts, { desc = 'Exit terminal mode' }))
vim.keymap.set('t', '<A-k>', [[<C-\><C-n><C-w>k]], vim.tbl_extend('force', opts, { desc = 'Focus window above' }))
vim.keymap.set('t', '<A-j>', [[<C-\><C-n><C-w>j]], vim.tbl_extend('force', opts, { desc = 'Focus window below' }))
vim.keymap.set('t', '<A-h>', [[<C-\><C-n><C-w>h]], vim.tbl_extend('force', opts, { desc = 'Focus left window' }))
vim.keymap.set('t', '<A-l>', [[<C-\><C-n><C-w>l]], vim.tbl_extend('force', opts, { desc = 'Focus right window' }))

-- VS Code Neovim skips plugin-related keymaps below
if not vim.g.vscode then

-----------------
--- LSP docs  ---
-----------------
vim.keymap.set("n", "gh", vim.lsp.buf.hover,          { desc = "LSP hover docs" })
vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "LSP signature help" })

-----------------
--- Telescope ---
-----------------
local ok, telescope_builtin = pcall(require, 'telescope.builtin')
if ok then
	vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = 'Find files' })
	vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep,  { desc = 'Live grep' })
	vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers,    { desc = 'Buffers' })
	vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags,  { desc = 'Help tags' })
end

end

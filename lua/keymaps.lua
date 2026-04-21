-- define common options
local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}

-----------------
--- Tabs move ---
-----------------
vim.keymap.set('n', '<leader>[', ':tabprevious<CR>', opts)
vim.keymap.set('n', '<leader>]', ':tabnext<CR>', opts)

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
-- Alt + 方向键缩放窗口
vim.keymap.set('n', '<A-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<A-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<A-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<A-Right>', ':vertical resize +2<CR>', opts)

-- Alt + hjkl 切换窗口（normal 模式）
vim.keymap.set('n', '<A-h>', '<C-w>h', opts)
vim.keymap.set('n', '<A-j>', '<C-w>j', opts)
vim.keymap.set('n', '<A-k>', '<C-w>k', opts)
vim.keymap.set('n', '<A-l>', '<C-w>l', opts)

-----------------
-- Visual mode --
-----------------
-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-----------------
--- Terminal  ---
-----------------
-- 终端模式下按 Esc 退出终端模式（进入 normal 模式）
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts)
-- 终端模式下用 Alt+方向键直接切换窗口
vim.keymap.set('t', '<A-k>', [[<C-\><C-n><C-w>k]], opts)
vim.keymap.set('t', '<A-j>', [[<C-\><C-n><C-w>j]], opts)
vim.keymap.set('t', '<A-h>', [[<C-\><C-n><C-w>h]], opts)
vim.keymap.set('t', '<A-l>', [[<C-\><C-n><C-w>l]], opts)

-- VS Code Neovim 模式下跳过插件相关键位
if not vim.g.vscode then

-----------------
--- LSP docs  ---
-----------------
-- gh: 快速查看光标下符号的文档（与 0.12 默认的 K 键功能相同，多一个选择）
vim.keymap.set("n", "gh", vim.lsp.buf.hover, { desc = "LSP hover docs" })
-- gs: 查看当前函数的签名
vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "LSP signature help" })

-----------------
--- Telescope ---
-----------------
-- Reserved keymaps; will be bound automatically when telescope is installed
local ok, telescope_builtin = pcall(require, 'telescope.builtin')
if ok then
    vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, { desc = 'Telescope help tags' })
end

end

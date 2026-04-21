require("options")
require("keymaps")

-- VS Code Neovim 模式下不加载插件（treesitter、lsp、dap、telescope 等）
if not vim.g.vscode then
    require("plugins")
end

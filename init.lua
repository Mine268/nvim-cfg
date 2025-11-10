require("options")

if vim.g.vscode then
    -- do not load plugins
else
   require("plugins")
end

require("keymaps")

if vim.g.vscode then
    -- do not setup lsp
else
    require("lsp")
end

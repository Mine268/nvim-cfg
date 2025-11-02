return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require('nvim-treesitter.configs').setup({
            -- 语言解析器列表：确保 c 和 cpp 在其中
            ensure_installed = { 'c', 'cpp', 'lua', 'vim' }, 
            auto_install = true,

            -- 启用核心功能
            highlight = {
                enable = true, -- **启用语法高亮**
            },

            -- 可选：启用基于树结构的智能缩进
            indent = { enable = true },
        })
    end
}

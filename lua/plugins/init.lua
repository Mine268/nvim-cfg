local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "nvim-tree/nvim-web-devicons", opts = {} },

    require("plugins.treesitter"),

    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },

    require("plugins.telescope"),
    
    require("plugins.gitsigns"),

    require("plugins.blink"),

    { "mason-org/mason.nvim", opts = {} },

    require("plugins.vim-illuminate"),

    require("plugins.auto-session"),
})

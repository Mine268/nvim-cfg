return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local actions = require("telescope.actions")
        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-t>"] = actions.select_tab,
                    },
                    n = {
                        ["<C-t>"] = actions.select_tab,
                    },
                },
            },
        })
    end,
}

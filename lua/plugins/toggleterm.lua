return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            direction = "horizontal",
            size = 15,
            open_mapping = [[<c-\>]],
            shell = vim.o.shell,
            hide_numbers = true,
            shade_terminals = true,
            start_in_insert = true,
            persist_size = true,
        })
    end,
}

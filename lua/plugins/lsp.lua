return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "clangd", "cmake" },
                automatic_installation = true,
            })

            local capabilities = require("blink.cmp").get_lsp_capabilities()

            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })
            vim.lsp.enable("lua_ls")

            vim.lsp.config("clangd", {
                capabilities = capabilities,
            })
            vim.lsp.enable("clangd")

            vim.lsp.config("cmake", {
                capabilities = capabilities,
            })
            vim.lsp.enable("cmake")
        end,
    },
}

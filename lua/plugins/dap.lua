return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "jay-babu/mason-nvim-dap.nvim",
            "williamboman/mason.nvim",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            -- 手动配置 codelldb
            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = "C:/Users/mine268/AppData/Local/nvim-data/mason/packages/codelldb/extension/adapter/codelldb.exe",
                    args = { "--port", "${port}" },
                },
            }

            dap.configurations.cpp = {
                {
                    name = "Launch file",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
            }
            dap.configurations.c = dap.configurations.cpp

            dapui.setup()

            local debug_tab = nil
            local prev_tab = nil

            local function open_dapui_tab()
                if debug_tab and vim.api.nvim_tabpage_is_valid(debug_tab) then
                    vim.api.nvim_set_current_tabpage(debug_tab)
                    return
                end
                prev_tab = vim.api.nvim_get_current_tabpage()
                vim.cmd("tabnew")
                debug_tab = vim.api.nvim_get_current_tabpage()
                dapui.open({ reset = true })
            end

            local function close_dapui_tab()
                if not debug_tab then return end
                if vim.api.nvim_tabpage_is_valid(debug_tab) then
                    local ok, err = pcall(function()
                        vim.cmd("tabclose " .. vim.api.nvim_tabpage_get_number(debug_tab))
                    end)
                    if not ok then
                        -- 若 tabclose 失败（如只剩一个 tab），直接关闭 dap-ui
                        dapui.close()
                    end
                end
                debug_tab = nil
                if prev_tab and vim.api.nvim_tabpage_is_valid(prev_tab) then
                    vim.api.nvim_set_current_tabpage(prev_tab)
                end
            end

            -- 调试开始时自动在新标签页打开 dap-ui
            dap.listeners.after.event_initialized["dapui_config"] = function()
                open_dapui_tab()
            end

            -- <leader>du: 若当前在 debug tab 则关闭它，否则打开/切到 debug tab
            local function toggle_dapui_tab()
                local current_tab = vim.api.nvim_get_current_tabpage()
                if debug_tab and current_tab == debug_tab then
                    close_dapui_tab()
                else
                    open_dapui_tab()
                end
            end

            vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
            vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
            vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
            vim.keymap.set("n", "<S-F11>", dap.step_out, { desc = "Debug: Step Out" })
            vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>du", toggle_dapui_tab, { desc = "Debug: Toggle UI (Tab)" })
        end,
    },
}

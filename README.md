# Neovim 配置文档

> 本文档用于后续维护交接，记录当前配置的所有插件、依赖、手动安装项及已知问题。

---

## 环境信息

| 项目 | 版本/说明 |
|------|----------|
| Neovim | v0.12.1 |
| 操作系统 | Windows |
| 包管理器 | [lazy.nvim](https://github.com/folke/lazy.nvim) |
| 终端 | Windows Terminal + PowerShell 7 (`pwsh.exe`) |
| Leader 键 | `<Space>` |

---

## 文件结构

```
├── init.lua                 -- 入口：加载 options、plugins、keymaps
├── lazy-lock.json           -- lazy.nvim 锁文件，记录插件精确版本
├── lua/
│   ├── options.lua          -- 基础选项（缩进、搜索、UI 等）
│   ├── keymaps.lua          -- 自定义键位映射
│   └── plugins/
│       ├── init.lua         -- lazy.nvim 引导 + 插件列表
│       ├── treesitter.lua   -- 语法高亮
│       ├── blink.lua        -- 补全引擎
│       ├── lsp.lua          -- LSP 配置
│       ├── telescope.lua    -- 模糊查找
│       ├── toggleterm.lua   -- 内嵌终端
│       └── dap.lua          -- 调试
```

---

## 插件清单

### 1. nvim-treesitter
- **用途**：基于 Treesitter 的语法高亮和智能缩进
- **配置**：`lua/plugins/treesitter.lua`
- **依赖**：无
- **已安装解析器**：`c`, `cpp`, `cmake`, `lua`, `vim`, `vimdoc`, `query`, `markdown`, `markdown_inline`
- **特殊说明**：
  - 使用 `branch = "master"`（而非 release tag）
  - **已知问题**：nvim 0.12 的 `Query:iter_matches()` API 变更导致 treesitter 崩溃。已在 `nvim-treesitter/lua/nvim-treesitter/query_predicates.lua` 中手动打补丁。该补丁会在 lazy.nvim 更新插件后被覆盖，若再次崩溃需重新应用。

### 2. blink.cmp
- **用途**：补全引擎（替代 nvim-cmp）
- **配置**：`lua/plugins/blink.lua`
- **依赖**：`rafamadriz/friendly-snippets`
- **版本**：`1.*`
- **关键配置**：
  - `<CR>` 确认选中项（`'accept'`）
  - 自动显示文档（`auto_show = true`, 延迟 500ms）
  - 签名帮助（`signature = { enabled = true }`）
  - 补全源：`lsp` → `path` → `snippets` → `buffer`

### 3. LSP 套件（nvim-lspconfig + mason）
- **用途**：语言服务器协议客户端及自动安装
- **配置**：`lua/plugins/lsp.lua`
- **依赖**：
  - `williamboman/mason.nvim` — LSP/DAP 安装器
  - `williamboman/mason-lspconfig.nvim` — mason 与 lspconfig 桥接
  - `saghen/blink.cmp` — 提供补全能力给 LSP
- **已启用 LSP**：

  | 语言服务器 | 用途 | 特殊配置 |
  |-----------|------|---------|
  | `lua_ls` | Lua | 诊断忽略 `vim` 全局变量 |
  | `clangd` | C/C++ | 无 |
  | `cmake` | CMake | 无 |

- **特殊说明**：
  - 使用 nvim 0.12 原生 API：`vim.lsp.config(name, opts)` + `vim.lsp.enable(name)`
  - `nvim-lspconfig` v2.x 已弃用旧版 `require('lspconfig').server.setup()` 方式
  - **CMake LSP 修复**：`cmake-language-server` 依赖的 `pygls` 需降级到 v1.2.1，否则崩溃。需在 mason 的虚拟环境中手动降级。

### 4. telescope.nvim
- **用途**：模糊查找器（文件、文本、buffer、帮助文档）
- **配置**：`lua/plugins/telescope.lua`
- **依赖**：`nvim-lua/plenary.nvim`
- **版本**：`0.1.8`
- **键位映射**（`lua/keymaps.lua`）：

  | 按键 | 功能 |
  |------|------|
  | `<leader>ff` | 查找文件 |
  | `<leader>fg` | 实时 grep（需 ripgrep） |
  | `<leader>fb` | 列出 buffer |
  | `<leader>fh` | 查找 help tags |

- **特殊说明**：`<C-t>` 在 telescope 结果中打开到新标签页
- **外部依赖**：系统需安装 `ripgrep`（`rg` 命令）

### 5. toggleterm.nvim
- **用途**：在 Neovim 内打开终端
- **配置**：`lua/plugins/toggleterm.lua`
- **依赖**：无
- **关键配置**：
  - 方向：底部水平面板（`direction = "horizontal"`, `size = 15`）
  - Shell：`pwsh.exe`（PowerShell 7）
  - 开启映射：`<C-\>`

### 6. 调试套件（nvim-dap + nvim-dap-ui）
- **用途**：Debug Adapter Protocol 调试及可视化界面
- **配置**：`lua/plugins/dap.lua`
- **依赖**：
  - `rcarriga/nvim-dap-ui` — 调试 UI
  - `nvim-neotest/nvim-nio` — nvim-dap-ui 的异步 IO 依赖
  - `jay-babu/mason-nvim-dap.nvim` — mason 集成（目前未实际用于安装 codelldb）
  - `williamboman/mason.nvim`
- **调试适配器**：`codelldb`（手动安装，见下方）
- **配置语言**：C/C++（通过 `codelldb`）
- **键位映射**：

  | 按键 | 功能 |
  |------|------|
  | `<F5>` | 启动/继续调试 |
  | `<F10>` | 单步跳过 |
  | `<F11>` | 单步进入 |
  | `<S-F11>` | 单步跳出 |
  | `<F9>` | 切换断点 |
  | `<leader>du` | 切换调试 UI（标签页模式） |

- **特殊说明**：
  - **dap-ui 标签页模式**：调试开始时自动新建一个标签页打开 dap-ui，与代码编辑标签页分离。按 `<leader>du` 可在 debug 标签页和代码标签页之间切换/关闭。
  - **Windows 闪退规避**：`event_terminated` / `event_exited` 上调用 `dapui.close()` 会导致 nvim 在 Windows 下闪退，已移除这两个自动关闭监听器。
  - **codelldb 手动安装**：mason 自动安装进程被杀，当前使用手动解压的 `.vsix` 文件，路径硬编码。若 mason 目录结构变化需重新验证。

---

## 手动安装的依赖

以下工具/组件未通过 lazy.nvim 或 mason 自动安装，需手动维护：

| 名称 | 安装位置 | 用途 | 维护注意 |
|------|---------|------|---------|
| **codelldb** | `%LOCALAPPDATA%\nvim-data\mason\packages\codelldb\extension\adapter\codelldb.exe` | C/C++ 调试适配器 | 手动解压 `.vsix`；路径在 `dap.lua` 中硬编码 |
| **ripgrep** | 系统 PATH | telescope `live_grep` | 需系统级安装 |
| **PowerShell 7** | 系统 PATH | toggleterm 默认 shell | 需系统级安装 `pwsh.exe` |

---

## 已知问题与注意事项

1. **treesitter 补丁耐久性**
   - `nvim-treesitter` 的 `query_predicates.lua` 手动打过补丁以兼容 nvim 0.12 的 `TSNode[]` 捕获。lazy.nvim 更新该插件后会覆盖补丁，需重新应用。

2. **codelldb 路径硬编码**
   - `dap.lua` 中 codelldb 的 `command` 是绝对路径。若 mason 目录结构变化或换机迁移，需修改该路径。

3. **Windows Terminal 键位拦截**
   - `<C-w>` 被 Windows Terminal 拦截，终端模式窗口切换使用 `<A-h/j/k/l>`。
   - `<C-\>` 用于 toggleterm，因为 `<C-`>` 在 Windows Terminal 中无法注册。

4. **CMake LSP 的 pygls 版本**
   - `cmake-language-server` 依赖 `pygls`。若 mason 自动更新导致 pygls 升级，可能再次崩溃，需手动回退到 v1.2.1。

5. **clangd 编译数据库**
   - 为使 clangd 正确解析项目头文件（如 Vulkan），需通过 CMake 生成 `compile_commands.json`。当前使用 `CMakeUserPresets.json` 配置 `CMAKE_EXPORT_COMPILE_COMMANDS=ON`，不修改 `CMakeLists.txt`。

---

## 常用维护命令

```vim
" 检查插件状态
:Lazy

" 更新所有插件
:Lazy update

" 检查 LSP 状态
:LspInfo

" 安装/更新 Treesitter 解析器
:TSUpdate

" 检查 Mason 安装的 LSP/DAP
:Mason
```

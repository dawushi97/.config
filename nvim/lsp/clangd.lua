-- C++ LSP (clangd) 优化配置 - 保证功能完整性，通过UI层控制显示
return {
  cmd = {
    "clangd",
    "--background-index", -- 后台索引，提升性能
    "--clang-tidy", -- 启用静态分析
    "--header-insertion=iwyu", -- 智能头文件插入
    "--completion-style=detailed", -- 详细补全信息
    "--function-arg-placeholders=false", -- 禁用参数占位符，减少视觉干扰
    "--pch-storage=memory", -- PCH存储在内存中，提升性能
    "--cross-file-rename", -- 支持跨文件重命名
    -- 移除了 --limit-results 让clangd提供完整建议
    -- 移除了 --ranking-model 使用默认排序
  },
  init_options = {
    usePlaceholders = false, -- 不使用占位符
    completeUnimported = true, -- 允许未导入的符号补全（.h文件声明）
    clangdFileStatus = true, -- 显示文件状态
    compilationDatabasePath = "", -- 编译数据库路径
  },
  settings = {
    clangd = {
      completion = {
        allScopes = true, -- 允许所有作用域的建议（支持.h文件声明）
      },
    },
  },
}
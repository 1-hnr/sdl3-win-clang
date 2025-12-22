# SDL3 Windows Clang-cl Build

Windows 原生构建项目，使用 CMake + Ninja + clang-cl 编译 SDL3。

## 项目信息

- 平台：Windows x64
- 构建系统：CMake 3.24+ / Ninja
- 编译器：clang-cl (LLVM)
- 运行时：MSVC /MD
- 目标：生成 SDL3 预编译二进制

## 常用命令

```bash
# 配置
cmake -S . -B build -G Ninja -DCMAKE_TOOLCHAIN_FILE=cmake/toolchain-clang-cl.cmake -DCMAKE_BUILD_TYPE=Release

# 构建
cmake --build build

# 安装
cmake --install build --prefix install

# 清理
rm -rf build install
```

## 关键文件

- @CMakeLists.txt - 主构建配置，使用 FetchContent 获取 SDL3
- @cmake/toolchain-clang-cl.cmake - clang-cl 工具链配置
- @.github/workflows/windows.yml - CI/CD 工作流

## 发布流程

1. 更新版本号（CMakeLists.txt 中的 SDL3_VERSION）
2. 创建 tag：`git tag v3.2.1+N`
3. 推送 tag：`git push origin v3.2.1+N`
4. GitHub Actions 自动构建并发布 release

## 行为要求

1. Ninja 必须显式安装，不假设默认存在
2. Windows + Ninja 场景必须显式指定 clang-cl
3. 优先给出最小可用解，再给扩展版本
4. 所有输出必须可直接复制运行
5. 出现编译器/生成器错误时，先从环境因果解释

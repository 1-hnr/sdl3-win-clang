# SDL3 Windows clang-cl 预编译项目

使用 FetchContent 从 GitHub 下载 SDL3 源码，通过 Ninja + clang-cl 编译，生成 shared/static 库。

## 当前版本
- SDL3: 3.2.28
- Tag 格式: `v3.2.28+N`

## 构建命令
```bash
cmake -S . -B build -G Ninja -DCMAKE_TOOLCHAIN_FILE=cmake/toolchain-clang-cl.cmake -DCMAKE_BUILD_TYPE=Release
cmake --build build
cmake --install build --prefix install
```

## 发布流程
```bash
git tag v3.2.28+N
git push origin v3.2.28+N
```
GitHub Actions 自动构建并发布。

## 关键路径
- CMakeLists.txt - FetchContent 获取 SDL3
- cmake/toolchain-clang-cl.cmake - 编译器配置
- .github/workflows/windows.yml - CI/CD

## CI 环境
- Runner: windows-latest
- 工具安装: `choco install llvm ninja`
- 编译器路径: `C:/Program Files/LLVM/bin/clang-cl.exe`
- Ninja 路径: `C:/ProgramData/chocolatey/bin/ninja.exe`

## 产出物
- SDL3.dll + SDL3.lib (动态库)
- SDL3-static.lib (静态库)

---
paths: CMakeLists.txt, cmake/**/*.cmake, .github/workflows/*.yml
---

# CMake Windows 构建规则

## Ninja 相关

- 使用 `-G Ninja` 时必须：
  - GitHub Actions 中显式安装 Ninja
  - 本地说明中明确要求已安装 Ninja
- 不假设 Ninja 默认存在于 Windows

## 编译器发现

- Windows + Ninja 必须显式指定：
  - `-DCMAKE_C_COMPILER=clang-cl`
  - `-DCMAKE_CXX_COMPILER=clang-cl`（若启用 C++）
- 或使用 toolchain 文件
- 不依赖 CMake 自动探测

## clang-cl 约定

- 必须来自 LLVM 官方发行版
- GitHub Actions 使用 `egor-tensin/setup-clang` 或 `install-llvm-action`
- 不使用 MSVC cl.exe 作为隐式回退

## CMakeLists 规则

- `cmake_minimum_required >= 3.24`
- 明确设置 `LANGUAGES C` 或 `C CXX`
- 设置 C 标准：`CMAKE_C_STANDARD 11` + `CMAKE_C_STANDARD_REQUIRED ON`
- 保持最小可用，不引入无关选项

## GitHub Actions 基线

Windows runner 必须包含：
1. checkout
2. setup ninja (lukka/get-cmake)
3. setup llvm (egor-tensin/setup-clang)
4. cmake configure（显式编译器或 toolchain）
5. cmake build

## 错误因果原则

以下错误优先判定为环境问题：
- `CMAKE_MAKE_PROGRAM is not set` → Ninja 未安装
- `CMAKE_C_COMPILER not set` → 编译器未指定
- `CMAKE_CXX_COMPILER not set` → 编译器未指定

## 输出风格

- 只输出可直接复制运行的代码
- 不输出"可能/也许/试试看"类建议
- 注释简洁工程化，非教程化

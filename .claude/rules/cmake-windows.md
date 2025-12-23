---
paths: CMakeLists.txt, cmake/*.cmake, .github/workflows/*.yml
---

# Windows CMake 构建规则

## 工具链
- 使用 chocolatey: `choco install llvm ninja`
- 必须显式指定完整路径，不依赖 PATH
- clang-cl: `C:/Program Files/LLVM/bin/clang-cl.exe`
- ninja: `C:/ProgramData/chocolatey/bin/ninja.exe`

## CMake 配置
- 必须传入 `-DCMAKE_C_COMPILER` 和 `-DCMAKE_CXX_COMPILER`
- 必须传入 `-DCMAKE_MAKE_PROGRAM`
- toolchain 文件不应覆盖命令行编译器设置

## 错误诊断
| 错误 | 原因 |
|------|------|
| CMAKE_MAKE_PROGRAM not set | Ninja 路径未指定 |
| CMAKE_C_COMPILER not set | 编译器路径未指定 |
| toolchain file not found | 路径或扩展名问题 |

## 输出要求
- 只输出可直接运行的代码
- 不输出"可能/试试"类建议

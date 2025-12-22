# ------------------------------------------------------------
# clang-cl toolchain for Windows (Ninja generator)
# ------------------------------------------------------------

# 目标平台
set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

# 使用 clang-cl（MSVC ABI）
set(CMAKE_C_COMPILER   clang-cl)
set(CMAKE_CXX_COMPILER clang-cl)

# 使用 lld-link（更快）
set(CMAKE_LINKER lld-link)

# MSVC runtime
# MultiThreadedDLL = /MD
# MultiThreaded    = /MT
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDLL")

# 统一 UTF-8
add_compile_options(/utf-8)

# Debug / Release flags
set(CMAKE_C_FLAGS_DEBUG   "/Zi /Od")
set(CMAKE_CXX_FLAGS_DEBUG "/Zi /Od")

set(CMAKE_C_FLAGS_RELEASE   "/O2 /DNDEBUG")
set(CMAKE_CXX_FLAGS_RELEASE "/O2 /DNDEBUG")

# clang-cl 兼容 MSVC 行为
add_compile_options(
  /EHsc          # C++ exceptions
  /Zc:__cplusplus
)

# 使用 clang-cl 风格的警告
add_compile_options(
  /W4
)

# ------------------------------------------------------------
# Search paths
# ------------------------------------------------------------

# 不污染系统环境
set(CMAKE_FIND_USE_SYSTEM_ENVIRONMENT_PATH OFF)

# 确保能找到 Windows SDK / MSVC
set(CMAKE_FIND_USE_PACKAGE_REGISTRY ON)

# ------------------------------------------------------------
# Diagnostics (helpful in CI)
# ------------------------------------------------------------

message(STATUS "Using clang-cl toolchain")
message(STATUS "C compiler: ${CMAKE_C_COMPILER}")
message(STATUS "CXX compiler: ${CMAKE_CXX_COMPILER}")
message(STATUS "MSVC runtime: ${CMAKE_MSVC_RUNTIME_LIBRARY}")

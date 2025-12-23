# ------------------------------------------------------------
# clang-cl toolchain for Windows (Ninja generator)
# ------------------------------------------------------------

# 目标平台
set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

# 编译器设置 - 仅在未通过命令行指定时设置默认值
if(NOT DEFINED CMAKE_C_COMPILER)
  find_program(CLANG_CL_PATH clang-cl
    PATHS
      "C:/Program Files/LLVM/bin"
      "$ENV{LLVM_PATH}/bin"
    NO_DEFAULT_PATH
  )
  if(CLANG_CL_PATH)
    set(CMAKE_C_COMPILER "${CLANG_CL_PATH}")
    set(CMAKE_CXX_COMPILER "${CLANG_CL_PATH}")
  else()
    # 回退到 PATH 中的 clang-cl
    set(CMAKE_C_COMPILER clang-cl)
    set(CMAKE_CXX_COMPILER clang-cl)
  endif()
endif()

# 链接器 - lld-link 更快
if(NOT DEFINED CMAKE_LINKER)
  find_program(LLD_LINK_PATH lld-link
    PATHS
      "C:/Program Files/LLVM/bin"
      "$ENV{LLVM_PATH}/bin"
    NO_DEFAULT_PATH
  )
  if(LLD_LINK_PATH)
    set(CMAKE_LINKER "${LLD_LINK_PATH}")
  endif()
endif()

# MSVC runtime: /MD (MultiThreadedDLL)
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

# 警告级别
add_compile_options(/W4)

# ------------------------------------------------------------
# Diagnostics
# ------------------------------------------------------------
message(STATUS "Using clang-cl toolchain")
message(STATUS "C compiler: ${CMAKE_C_COMPILER}")
message(STATUS "CXX compiler: ${CMAKE_CXX_COMPILER}")
message(STATUS "MSVC runtime: ${CMAKE_MSVC_RUNTIME_LIBRARY}")

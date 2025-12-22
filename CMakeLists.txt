cmake_minimum_required(VERSION 3.24)

# ------------------------------------------------------------
# Project
# ------------------------------------------------------------
project(
  SDL3
  VERSION 3.2.1
  LANGUAGES C CXX
)

# ------------------------------------------------------------
# Build options (keep minimal, SDL-style)
# ------------------------------------------------------------
option(SDL_SHARED "Build SDL shared library" ON)
option(SDL_STATIC "Build SDL static library" OFF)

# ------------------------------------------------------------
# Global settings
# ------------------------------------------------------------
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Default build type (Ninja / CI)
if(NOT CMAKE_CONFIGURATION_TYPES AND NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "" FORCE)
endif()

# ------------------------------------------------------------
# Sources (示例，按你仓库真实文件替换)
# ------------------------------------------------------------
set(SDL3_SOURCES
  src/SDL.c
  src/SDL_assert.c
)

set(SDL3_HEADERS
  include/SDL3/SDL.h
)

# ------------------------------------------------------------
# Library
# ------------------------------------------------------------
add_library(SDL3 ${SDL3_SOURCES} ${SDL3_HEADERS})

if(SDL_SHARED)
  set_target_properties(SDL3 PROPERTIES WINDOWS_EXPORT_ALL_SYMBOLS ON)
endif()

target_include_directories(SDL3
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)

# Windows defines
if(WIN32)
  target_compile_definitions(SDL3 PRIVATE NOMINMAX WIN32_LEAN_AND_MEAN)
endif()

# MSVC / clang-cl warnings
if(MSVC)
  target_compile_options(SDL3 PRIVATE /W3)
endif()

# ------------------------------------------------------------
# Install
# ------------------------------------------------------------
include(GNUInstallDirs)

install(
  TARGETS SDL3
  EXPORT SDL3Targets
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(
  DIRECTORY include/
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

# ------------------------------------------------------------
# CMake package config (find_package)
# ------------------------------------------------------------
install(
  EXPORT SDL3Targets
  FILE SDL3Targets.cmake
  NAMESPACE SDL3::
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/SDL3
)

# ------------------------------------------------------------
# Summary
# ------------------------------------------------------------
message(STATUS "")
message(STATUS "========== SDL3 Build ==========")
message(STATUS "Version:        ${PROJECT_VERSION}")
message(STATUS "Compiler:       ${CMAKE_C_COMPILER_ID}")
message(STATUS "Build type:     ${CMAKE_BUILD_TYPE}")
message(STATUS "Shared:         ${SDL_SHARED}")
message(STATUS "================================")

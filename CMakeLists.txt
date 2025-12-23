cmake_minimum_required(VERSION 3.24)

# ------------------------------------------------------------
# Project
# ------------------------------------------------------------
project(
  SDL3-Build
  VERSION 3.2.28
  LANGUAGES C CXX
)

# ------------------------------------------------------------
# Options
# ------------------------------------------------------------
set(SDL3_VERSION "3.2.28" CACHE STRING "SDL3 version to download")

# Default build type
if(NOT CMAKE_CONFIGURATION_TYPES AND NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "" FORCE)
endif()

# ------------------------------------------------------------
# FetchContent - Download SDL3 source
# ------------------------------------------------------------
include(FetchContent)

FetchContent_Declare(
  SDL3
  URL https://github.com/libsdl-org/SDL/releases/download/release-${SDL3_VERSION}/SDL3-${SDL3_VERSION}.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
)

# SDL3 build options (before FetchContent_MakeAvailable)
set(SDL_SHARED ON CACHE BOOL "" FORCE)  # 动态库 (SDL3.dll)
set(SDL_STATIC ON CACHE BOOL "" FORCE)  # 静态库 (SDL3-static.lib)
set(SDL_TEST_LIBRARY OFF CACHE BOOL "" FORCE)
set(SDL_TESTS OFF CACHE BOOL "" FORCE)
set(SDL_EXAMPLES OFF CACHE BOOL "" FORCE)
set(SDL_DISABLE_INSTALL OFF CACHE BOOL "" FORCE)

# Fetch and build SDL3
FetchContent_MakeAvailable(SDL3)

# ------------------------------------------------------------
# Summary
# ------------------------------------------------------------
message(STATUS "")
message(STATUS "========== SDL3 Build Configuration ==========")
message(STATUS "SDL3 Version:   ${SDL3_VERSION}")
message(STATUS "Compiler:       ${CMAKE_C_COMPILER_ID}")
message(STATUS "Build type:     ${CMAKE_BUILD_TYPE}")
message(STATUS "Install prefix: ${CMAKE_INSTALL_PREFIX}")
message(STATUS "===============================================")

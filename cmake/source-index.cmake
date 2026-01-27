# ------------------------------------------------------------
# SDL3 Source Index for IDE
# ------------------------------------------------------------
# This script fetches SDL3 source code for IDE indexing/debugging.
# The source is NOT used for compilation - only for code navigation.
#
# Usage in your project:
#   include(${sdl3_SOURCE_DIR}/cmake/source-index.cmake)
#
# Or set SDL3_FETCH_SOURCE before find_package:
#   set(SDL3_FETCH_SOURCE ON)
#   find_package(SDL3 CONFIG REQUIRED)
# ------------------------------------------------------------

option(SDL3_FETCH_SOURCE "Fetch SDL3 source for IDE indexing (not for compilation)" OFF)

if(SDL3_FETCH_SOURCE)
  include(FetchContent)

  # Version must match the prebuilt package
  set(SDL3_SOURCE_VERSION "3.2.28" CACHE STRING "SDL3 source version to fetch")
  set(SDL3_SOURCE_GIT_TAG "release-${SDL3_SOURCE_VERSION}")

  FetchContent_Declare(
    SDL3_SOURCE
    GIT_REPOSITORY https://github.com/libsdl-org/SDL.git
    GIT_TAG ${SDL3_SOURCE_GIT_TAG}
    GIT_SHALLOW TRUE
    SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/../source"
  )

  # Only populate, don't configure/build
  FetchContent_GetProperties(SDL3_SOURCE)
  if(NOT sdl3_source_POPULATED)
    message(STATUS "Fetching SDL3 source for IDE indexing...")
    FetchContent_Populate(SDL3_SOURCE)
    message(STATUS "SDL3 source available at: ${sdl3_source_SOURCE_DIR}")
  endif()

  # Help IDE find the source
  set(SDL3_SOURCE_DIR "${sdl3_source_SOURCE_DIR}" CACHE PATH "SDL3 source directory for IDE" FORCE)
endif()

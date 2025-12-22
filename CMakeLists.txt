cmake_minimum_required(VERSION 3.25)

# ------------------------------------------------------------
# SDL upstream version
# ------------------------------------------------------------
set(SDL_UPSTREAM_VERSION "3.2.1")

project(
  sdl3-clang-win64
  VERSION ${SDL_UPSTREAM_VERSION}
  LANGUAGES C CXX
)

include(GNUInstallDirs)
include(FetchContent)
include(CMakePackageConfigHelpers)

# ------------------------------------------------------------
# Fetch SDL3 source
# ------------------------------------------------------------
FetchContent_Declare(
  SDL3
  GIT_REPOSITORY https://github.com/libsdl-org/SDL.git
  GIT_TAG release-${SDL_UPSTREAM_VERSION}
)

FetchContent_MakeAvailable(SDL3)

# ------------------------------------------------------------
# SDL build options
# ------------------------------------------------------------
set(SDL_SHARED ON CACHE BOOL "" FORCE)
set(SDL_STATIC OFF CACHE BOOL "" FORCE)
set(SDL_TEST OFF CACHE BOOL "" FORCE)

# ------------------------------------------------------------
# Install targets
# ------------------------------------------------------------
install(TARGETS SDL3-shared
  EXPORT SDL3Targets
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(DIRECTORY
  ${SDL3_SOURCE_DIR}/include/
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

# ------------------------------------------------------------
# CMake package config
# ------------------------------------------------------------
install(EXPORT SDL3Targets
  NAMESPACE SDL3::
  DESTINATION lib/cmake/SDL3
)

write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/SDL3ConfigVersion.cmake"
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion
)

install(FILES
  "${CMAKE_CURRENT_BINARY_DIR}/SDL3ConfigVersion.cmake"
  DESTINATION lib/cmake/SDL3
)

# SDL3 (Windows x64, clang-cl)

Prebuilt SDL3 binaries for Windows.

## Versioning

Tag format:

v<SDL_VERSION>+<REV>

Example:

- v3.2.1+1
- v3.2.1+2

## ABI

- Compiler: clang-cl
- Runtime: MSVC /MD
- Arch: x64
- C++: C++20

## CMake Usage

```cmake
include(FetchContent)

FetchContent_Declare(
  sdl3
  URL https://github.com/<you>/sdl3-win-clang/releases/download/v3.2.1+1/sdl3-clang-win64.zip
)

FetchContent_MakeAvailable(sdl3)

list(APPEND CMAKE_PREFIX_PATH ${sdl3_SOURCE_DIR})

find_package(SDL3 CONFIG REQUIRED)

target_link_libraries(app PRIVATE SDL3::SDL3-shared)
```

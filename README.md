# SDL3 (Windows x64, clang-cl)

Prebuilt SDL3 binaries for Windows using clang-cl compiler.

## Features

- Compiler: clang-cl (LLVM/Clang with MSVC ABI)
- Linker: lld-link
- Runtime: MSVC /MD (MultiThreadedDLL)
- Architecture: x64
- Build type: Release (optimized)

## Versioning

Tag format: `v<SDL_VERSION>+<REV>`

Examples:
- `v3.2.28+1` - First build of SDL 3.2.28
- `v3.2.28+2` - Second build (toolchain or config update)

## Download

Get the latest release from [Releases](https://github.com/1-hnr/sdl3-win-clang/releases).

## CMake Usage

### Option 1: FetchContent (Recommended)

```cmake
include(FetchContent)

FetchContent_Declare(
  sdl3
  URL https://github.com/1-hnr/sdl3-win-clang/releases/download/v3.2.28+1/sdl3-windows-clang-cl.zip
)

FetchContent_MakeAvailable(sdl3)
list(APPEND CMAKE_PREFIX_PATH ${sdl3_SOURCE_DIR})

find_package(SDL3 CONFIG REQUIRED)
target_link_libraries(your_app PRIVATE SDL3::SDL3)
```

### Option 2: Manual Download

1. Download and extract the release zip
2. Set `CMAKE_PREFIX_PATH` to the extracted directory
3. Use `find_package(SDL3 CONFIG REQUIRED)`

## Package Contents

```
install/
├── bin/
│   └── SDL3.dll
├── lib/
│   ├── SDL3.lib
│   └── cmake/SDL3/
│       ├── SDL3Config.cmake
│       ├── SDL3ConfigVersion.cmake
│       └── SDL3Targets.cmake
└── include/
    └── SDL3/
        └── *.h
```

## Building Locally

Requirements:
- CMake 3.24+
- Ninja
- LLVM/Clang (clang-cl)

```bash
cmake -S . -B build -G Ninja -DCMAKE_TOOLCHAIN_FILE=cmake/toolchain-clang-cl.cmake -DCMAKE_BUILD_TYPE=Release
cmake --build build
cmake --install build --prefix install
```

## License

SDL3 is licensed under the zlib license. See [SDL License](https://github.com/libsdl-org/SDL/blob/main/LICENSE.txt).

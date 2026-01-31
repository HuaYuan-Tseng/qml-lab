# Copilot Instructions for qml-lab

- Use the zh-TW to response.

## Tech Stack & Architecture

- **Language:** C++ (C++23 standard)
- **Framework:** Qt 6 (QtQuick/QML for UI)
- **Build System:** CMake (min. version 3.21)
- **Containerization:** Docker (Ubuntu 24.04 base)
- **Formatting/Linting:** clang-format, clang-tidy

## Key Directories & Files

- `src/app/main.cpp` — C++ application entry point
- `src/app/qml/Main.qml` — Main QML UI file
- `CMakeLists.txt` — Main build configuration
- `cmake/` — CMake helper scripts and settings
- `Dockerfile` — Development/build environment setup
- `.clang-format`, `.clang-tidy` — Code style and linting rules
- `bin/` — Build output directory
- `build/` — CMake build artifacts

## Build & Run

- **Configure & Build (native):**
  ```sh
  mkdir -p build && cd build
  cmake ..
  make
  ```
- **Run:**
  ```
  ./bin/Debug/qml-lab-app.app/Contents/MacOS/qml-lab-app
  ```
- **Docker Build:**
  ```
  docker build -t qml-lab .
  ```

## Testing

- No explicit test suite detected; add tests in `src/` and integrate with CTest for CMake.

## Project Conventions

- **No in-source builds:** Always build in a separate `build/` directory.
- **QML files:** Place under `src/app/qml/`.
- **C++ sources:** Place under `src/app/`.
- **Follow `.clang-format` and `.clang-tidy` for code style and linting.**
- **CMake options:** Project enables AUTOUIC, AUTOMOC, AUTORCC for Qt integration.

## Additional Notes

- The main QML file is loaded via `engine.loadFromModule("QmlLab", "Main");`.
- For custom CMake logic, see scripts in `cmake/`.
- For environment setup, refer to the `Dockerfile` for dependencies and tools.


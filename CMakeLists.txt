cmake_minimum_required(VERSION 3.21)

project(qml-lab
    VERSION 0.1.0
    LANGUAGES CXX
)

# -----------------------------------------------------------------------------
# Include guards.
# -----------------------------------------------------------------------------

if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
    message(
        FATAL_ERROR
        "In-source builds not allowed. \
        Please make a new directory (called a build directory) \
        and run CMake from there."
    )
endif()

# -----------------------------------------------------------------------------
# Set project options.
# -----------------------------------------------------------------------------

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_DEBUG_POSTFIX "")
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_COLOR_DIAGNOSTICS ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Enable unicode for all projects.
add_definitions(-DUNICODE -D_UNICODE)

# -----------------------------------------------------------------------------
# Include other cmake files.
# -----------------------------------------------------------------------------

execute_process(
    COMMAND bash ${CMAKE_SOURCE_DIR}/cmake/generate-sources.sh
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    RESULT_VARIABLE GENERATE_SOURCES_RESULT
    ERROR_VARIABLE GENERATE_SOURCES_ERROR
)

if(NOT GENERATE_SOURCES_RESULT EQUAL 0)
    message(FATAL_ERROR "Failed to generate the sources and headers files:
            ${GENERATE_SOURCES_ERROR}")
endif()

include(cmake/sources.cmake)
include(cmake/standard-settings.cmake)
include(cmake/utils.cmake)
include(cmake/static-analyzers.cmake)
include(cmake/compiler-warnings.cmake)

# -----------------------------------------------------------------------------
# Set building type.
# -----------------------------------------------------------------------------

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

# This will allow to use same _DEBUG macro available in both Linux
# as well as Windows - MSCV environment. Easy to put Debug specific code.
if(UNIX)
    add_compile_options("$<$<CONFIG:DEBUG>:-D_DEBUG>")
endif()

# -----------------------------------------------------------------------------
# Set output directories.
# -----------------------------------------------------------------------------

# First for the generic no-config case (e.g. with mingw)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin/${CMAKE_BUILD_TYPE})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin/${CMAKE_BUILD_TYPE})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin/${CMAKE_BUILD_TYPE})
set(CMAKE_COMPILE_PDB_OUTPUT_DIRECTORY
    ${CMAKE_SOURCE_DIR}/bin/${CMAKE_BUILD_TYPE})

# Second, for multi-config builds (e.g. msvc)
foreach(OUTPUT_CONFIG ${CMAKE_CONFIGURATION_TYPES})
    string(TOUPPER ${OUTPUT_CONFIG} OUTPUT_CONFIG)

    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${OUTPUT_CONFIG}
        ${CMAKE_SOURCE_DIR}/bin/${CMAKE_BUILD_TYPE})

    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_${OUTPUT_CONFIG}
        ${CMAKE_SOURCE_DIR}/bin/${CMAKE_BUILD_TYPE})

    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_${OUTPUT_CONFIG}
        ${CMAKE_SOURCE_DIR}/bin/${CMAKE_BUILD_TYPE})

    set(CMAKE_COMPILE_PDB_OUTPUT_DIRECTORY_${OUTPUT_CONFIG}
        ${CMAKE_SOURCE_DIR}/bin/${CMAKE_BUILD_TYPE})
endforeach()

# -----------------------------------------------------------------------------
# Setup dependencies.
# -----------------------------------------------------------------------------

if(APPLE)
    # Qt 6.8's FindWrapOpenGL.cmake has a bug where it forces -framework AGL
    # even if it's not found in the SDK. We pre-emptively create the target
    # to avoid this.
    if(NOT TARGET WrapOpenGL::WrapOpenGL)
        add_library(WrapOpenGL::WrapOpenGL INTERFACE IMPORTED)
        target_link_libraries(WrapOpenGL::WrapOpenGL INTERFACE "-framework OpenGL")
    endif()
    set(WrapOpenGL_FOUND ON CACHE BOOL "" FORCE)
endif()

find_package(Qt6
    COMPONENTS
    Core
    Quick
    REQUIRED
)

qt_policy(SET QTP0001 NEW)
qt_policy(SET QTP0004 NEW)

# ------------------------------------------------------------------------------
# Headers and sources.
# ------------------------------------------------------------------------------

# --- Hello QML ---

set(HELLO_QML_APP "hello-qml-app")

qt_standard_project_setup()
qt_add_executable(${HELLO_QML_APP} "")
qt_add_qml_module(${HELLO_QML_APP}
    URI HelloQML
    VERSION 1.0
    QML_FILES
    ${HELLO_QML_QML}
)
target_sources(${HELLO_QML_APP}
    PRIVATE
    ${HELLO_QML_SOURCE}
)
target_include_directories(${HELLO_QML_APP}
    PRIVATE
    ${CMAKE_SOURCE_DIR}/src/hello-qml
)
target_link_libraries(${HELLO_QML_APP}
    PRIVATE
    Qt6::Quick
)
set_target_properties(${HELLO_QML_APP}
    PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER ${PROJECT_NAME}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

# --- Signal Slot ---

set(SIGNAL_SLOT_APP "signal-slot-app")

qt_standard_project_setup()
qt_add_executable(${SIGNAL_SLOT_APP} "")
target_sources(${SIGNAL_SLOT_APP}
    PRIVATE
    ${SIGNAL_SLOT_SOURCE}
)
target_include_directories(${SIGNAL_SLOT_APP}
    PRIVATE
    ${CMAKE_SOURCE_DIR}/src/signal-slot
)
target_link_libraries(${SIGNAL_SLOT_APP}
    PRIVATE
    Qt6::Core
)
set_target_properties(${SIGNAL_SLOT_APP}
    PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER ${PROJECT_NAME}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

# --- QObject Tree ---

set(QOBJECT_TREE_APP "qobject-tree-app")

qt_standard_project_setup()
qt_add_executable(${QOBJECT_TREE_APP} "")
target_sources(${QOBJECT_TREE_APP}
    PRIVATE
    ${QOBJECT_TREE_SOURCE}
)
target_include_directories(${QOBJECT_TREE_APP}
    PRIVATE
    ${CMAKE_SOURCE_DIR}/src/qobject-tree
)
target_link_libraries(${QOBJECT_TREE_APP}
    PRIVATE
    Qt6::Core
)
set_target_properties(${QOBJECT_TREE_APP}
    PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER ${PROJECT_NAME}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

# --- Intro Quick ---

set(INTRO_QUICK_APP "intro-quick-app")

qt_standard_project_setup()
qt_add_executable(${INTRO_QUICK_APP} "")
qt_add_qml_module(${INTRO_QUICK_APP}
    URI IntroQuick
    VERSION 1.0
    QML_FILES
    ${INTRO_QUICK_QML}
)
target_sources(${INTRO_QUICK_APP}
    PRIVATE
    ${INTRO_QUICK_SOURCE}
)
target_include_directories(${INTRO_QUICK_APP}
    PRIVATE
    ${CMAKE_SOURCE_DIR}/src/qobject-tree
)
target_link_libraries(${INTRO_QUICK_APP}
    PRIVATE
    Qt6::Core
    Qt6::Quick
)
set_target_properties(${INTRO_QUICK_APP}
    PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER ${PROJECT_NAME}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

# -----------------------------------------------------------------------------
# Set the building and warning options.
# -----------------------------------------------------------------------------

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -O0")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -O0")
elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
    set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -O3")
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3")
endif()

set_project_warnings(${HELLO_QML_APP})
set_project_warnings(${SIGNAL_SLOT_APP})
set_project_warnings(${QOBJECT_TREE_APP})

# -----------------------------------------------------------------------------
# Print the final status.
# -----------------------------------------------------------------------------

message(STATUS "--------------------")
message(STATUS "Configure Result:   ")
message(STATUS "--------------------")
message(STATUS "Project Name: ${PROJECT_NAME}")
message(STATUS "Project Version: ${PROJECT_VERSION}")
message(STATUS "System Name: ${CMAKE_SYSTEM_NAME}")
message(STATUS "System Version: ${CMAKE_SYSTEM_VERSION}")
message(STATUS "System Processor: ${CMAKE_SYSTEM_PROCESSOR}")
message(STATUS "Build Type: ${CMAKE_BUILD_TYPE}")
message(STATUS "C Version: ${CMAKE_C_STANDARD}")
message(STATUS "C++ Version: ${CMAKE_CXX_STANDARD}")
message(STATUS "C Compiler: ${CMAKE_C_COMPILER_ID} ${CMAKE_C_COMPILER_VERSION}")
message(STATUS "C++ Compiler: ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}")
message(STATUS "C Flags: ${CMAKE_C_FLAGS}")
message(STATUS "C Debug Flags: ${CMAKE_C_FLAGS_DEBUG}")
message(STATUS "C Release Flags: ${CMAKE_C_FLAGS_RELEASE}")
message(STATUS "C++ Flags: ${CMAKE_CXX_FLAGS}")
message(STATUS "C++ Debug Flags: ${CMAKE_CXX_FLAGS_DEBUG}")
message(STATUS "C++ Release Flags: ${CMAKE_CXX_FLAGS_RELEASE}")
message(STATUS "Linker Flags: ${CMAKE_EXE_LINKER_FLAGS}")
message(STATUS "Qt Version: ${Qt6_VERSION}")
message(STATUS "--------------------")
message(STATUS "Treat Warnings As Errors: ${${PROJECT_NAME}_WARNINGS_AS_ERRORS}")
message(STATUS "Export Compile Commands: ${${PROJECT_NAME}_EXPORT_COMPILE_COMMANDS}")
message(STATUS "Enable Conan: ${${PROJECT_NAME}_ENABLE_CONAN}")
message(STATUS "Enable VCPKG: ${${PROJECT_NAME}_ENABLE_VCPKG}")
message(STATUS "Enable Clang-Format: ${${PROJECT_NAME}_ENABLE_CLANG_FORMAT}")
message(STATUS "Enable Clang-Tidy: ${${PROJECT_NAME}_ENABLE_CLANG_TIDY}")
message(STATUS "Enable Clang-Tidy When Building: ${${PROJECT_NAME}_ENABLE_CLANG_TIDY_WHEN_BUILD}")
message(STATUS "Enable CppCheck: ${${PROJECT_NAME}_ENABLE_CPPCHECK}")
message(STATUS "Enable CppCheck When Building: ${${PROJECT_NAME}_ENABLE_CPPCHECK_WHEN_BUILD}")
message(STATUS "Enable CCache: ${${PROJECT_NAME}_ENABLE_CCACHE}")
message(STATUS "Enable LTO: ${${PROJECT_NAME}_ENABLE_LTO}")
message(STATUS "Enable Testing: ${${PROJECT_NAME}_ENABLE_TESTING}")
message(STATUS "Enable Code Coverage: ${${PROJECT_NAME}_ENABLE_CODE_COVERAGE}")
message(STATUS "Enable Address Sanitizer: ${${PROJECT_NAME}_ENABLE_ASAN}")
message(STATUS "Enable Leak Sanitizer: ${${PROJECT_NAME}_ENABLE_LSAN}")
message(STATUS "Enable Thread Sanitizer: ${${PROJECT_NAME}_ENABLE_TSAN}")
message(STATUS "Enable Undefined Behavior Sanitizer: ${${PROJECT_NAME}_ENABLE_USAN}")
message(STATUS "Enable Memory Sanitizer: ${${PROJECT_NAME}_ENABLE_MSAN}")
message(STATUS "--------------------")


# ----- Compiler options ----- #

# XXX: Because it is too strict, currently closed.
option(${PROJECT_NAME}_WARNINGS_AS_ERRORS
    "Treat compiler warnings as errors." OFF
)

# ----- Package managers ----- #

option(${PROJECT_NAME}_ENABLE_CONAN
    "Enable the Conan package manager for this project." OFF
)
option(${PROJECT_NAME}_ENABLE_VCPKG
    "Enable the Vcpkg package manager for this project." OFF
)

# ----- Static analyzers ----- #

option(${PROJECT_NAME}_ENABLE_CLANG_TIDY
    "Enable static analysis with Clang-Tidy." ON
)
option(${PROJECT_NAME}_ENABLE_CLANG_TIDY_WHEN_BUILD
    "Enable static analysis with Clang-Tidy when building." OFF
)
option(${PROJECT_NAME}_ENABLE_CPPCHECK
    "Enable static analysis with Cppcheck." OFF
)
option(${PROJECT_NAME}_ENABLE_CPPCHECK_WHEN_BUILD
    "Enable static analysis with Cppcheck when building." ON
)

# ----- Formatter ----- #

option(${PROJECT_NAME}_ENABLE_CLANG_FORMAT
    "Enable code formatting with Clang-Format." ON
)

# ----- Testing ----- #

option(${PROJECT_NAME}_ENABLE_TESTING
    "Enable tests for the projects (from the `test` subfolder)." ON
)

# ----- Code coverage ----- #

option(${PROJECT_NAME}_ENABLE_CODE_COVERAGE
    "Enable code coverage." OFF
)

# In Debug mode, the "Code Coverage" option is enabled by default.
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(${PROJECT_NAME}_ENABLE_CODE_COVERAGE ON)
endif()

# ----- Miscellaneous options ----- #

# Enable the Copy necessary files to the output directory or not.
option(${PROJECT_NAME}_ENABLE_COPY_FILES
    "Enable the Copy necessary files to the output directory." ON
)

# Configure symbol visibility for shared libraries.
if(BUILD_SHARED_LIBS)
    set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS OFF)
    set(CMAKE_C_VISIBILITY_PRESET hidden)
    set(CMAKE_CXX_VISIBILITY_PRESET hidden)
    set(CMAKE_VISIBILITY_INLINES_HIDDEN 1)
endif()

# Enable Inter-procedural optimization or not.
option(${PROJECT_NAME}_ENABLE_LTO
    "Enable Link Time Optimization (LTO)." OFF
)

if(${PROJECT_NAME}_ENABLE_LTO)
    include(CheckIPOSupported)
    check_ipo_supported(RESULT result OUTPUT output)

    if(result)
        set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE)
    else()
        message(SEND_ERROR "IPO is not supported: ${output}.")
    endif()
endif()

# Enable Ccache or not.
option(${PROJECT_NAME}_ENABLE_CCACHE
    "Enable the usage of Ccache, in order to speed up rebuild times." ON
)
find_program(CCACHE_FOUND ccache)

if(${PROJECT_NAME}_ENABLE_CCACHE AND CCACHE_FOUND)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ccache)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK ccache)
    message(STATUS "Ccache enabled.")
endif()

# ----- Sanitizer options ----- #

# Enable Address Sanitizer or not.
option(${PROJECT_NAME}_ENABLE_ASAN
    "Enable Address Sanitizer to detect memory error." ON
)

if(${PROJECT_NAME}_ENABLE_ASAN)
    if(UNIX)
        add_compile_options(-fsanitize=address)
        add_link_options(-fsanitize=address)
    endif()
endif()

# Enable Leak Sanitizer or not.
option(${PROJECT_NAME}_ENABLE_LSAN
    "Enable Leak Sanitizer to detect memory error." OFF
)

if(${PROJECT_NAME}_ENABLE_LSAN)
    if(UNIX)
        add_compile_options(-fsanitize=leak)
        add_link_options(-fsanitize=leak)
    endif()
endif()

# Enable Thread Sanitizer or not.
# Cannot be used with Address Sanitizer at the same time!
option(${PROJECT_NAME}_ENABLE_TSAN
    "Enable Thread Sanitizer to detect memory error." OFF
)

if(${PROJECT_NAME}_ENABLE_TSAN)
    if(UNIX)
        # MSVC's Clang doesn't have TSAN.
        add_compile_options(-fsanitize=thread)
        add_link_options(-fsanitize=thread)
    endif()
endif()

# Enable Undefined Behavior Sanitizer or not.
option(${PROJECT_NAME}_ENABLE_USAN
    "Enable Undefined Behavior Sanitizer to detect memory error." OFF
)

if(${PROJECT_NAME}_ENABLE_USAN)
    if(UNIX)
        add_compile_options(-fsanitize=undefined)
        add_link_options(-fsanitize=undefined)
    endif()
endif()

# Enable Memory Sanitizer or not.
# Cannot be used with Address Sanitizer at the same time!
option(${PROJECT_NAME}_ENABLE_MSAN
    "Enable Memory Sanitizer to detect memory error." OFF
)

if(${PROJECT_NAME}_ENABLE_MSAN)
    if(UNIX)
        add_compile_options(-fsanitize=memory)
        add_link_options(-fsanitize=memory)
    endif()
endif()

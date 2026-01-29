# ----- Add a target for formating the project using `clang-format`. ----- #
# ----- (i.e.: cmake --build build --target clang-format)            ----- #

if (${PROJECT_NAME}_ENABLE_CLANG_FORMAT)
    find_program(CLANG_FORMAT_PROGRAM clang-format)
    if (NOT CLANG_FORMAT_PROGRAM)
        message(WARNING "Clang-format not found, skipping target creation.")
    endif ()
    add_custom_target(CLANG_FORMAT
        COMMAND ${CLANG_FORMAT_PROGRAM}
                -i
                ${APP_SOURCE}
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        VERBATIM
    )
    message(STATUS "Clang-format target added.")
endif ()

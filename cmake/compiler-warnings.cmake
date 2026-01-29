# from here:
#
# https://github.com/lefticus/cppbestpractices/blob/master/02-Use_the_Tools_Available.md
# Courtesy of Jason Turner

function (set_project_warnings project_name)
    set(MSVC_WARNINGS
        /W4             # Baseline reasonable warnings
        /w14263         # 'function': member function does not override any base class
                        # virtual member function
        /w14265         # 'classname': class has virtual functions, but destructor is not
                        # virtual instances of this class may not be destructed correctly
        /w14287         # 'operator': unsigned/negative constant mismatch
        /w14311         # 'variable': pointer truncation from 'type1' to 'type2'
        /w14545         # expression before comma evaluates to a function which is missing
                        # an argument list
        /w14640         # Enable warning on thread un-safe static member initialization
        /w14826         # Conversion from 'type1' to 'type_2' is sign-extended. This may
                        # cause unexpected runtime behavior.
        /w14928         # illegal copy-initialization; more than one user-defined
                        # conversion has been implicitly applied
        /permissive-    # standards conformance mode for MSVC compiler.
        /wd4458
        /wd4251
    )

    set(CLANG_WARNINGS
        -Wall
        -Wextra                 # reasonable and standard
        -Wnon-virtual-dtor      # warn the user if a class with virtual functions has a
                                # non-virtual destructor. This helps catch hard to
                                # track down memory errors
        -Wcast-align            # warn for potential performance problem casts
        -Wunused                # warn on anything being unused
        -Woverloaded-virtual    # warn if you overload (not override) a virtual
                                # function
        -Wpedantic              # warn if non-standard C++ is used
        -Wnull-dereference      # warn if a null dereference is detected
        -Wdouble-promotion      # warn if float is implicit promoted to double
        -Wformat=2              # warn on security issues around functions that format output
                                # (ie printf)
    )

    if (${PROJECT_NAME}_WARNINGS_AS_ERRORS)
        set(CLANG_WARNINGS ${CLANG_WARNINGS} -Werror)
        set(MSVC_WARNINGS ${MSVC_WARNINGS} /WX)
    endif ()

    set(GCC_WARNINGS ${CLANG_WARNINGS})

    if (MSVC)
        set(PROJECT_WARNINGS ${MSVC_WARNINGS})
    elseif (CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")
        set(PROJECT_WARNINGS ${CLANG_WARNINGS})
    elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
        set(PROJECT_WARNINGS ${GCC_WARNINGS})
    else ()
        message(AUTHOR_WARNING "No compiler warnings set \
            for '${CMAKE_CXX_COMPILER_ID}' compiler.")
    endif ()

    if (${PROJECT_NAME}_BUILD_HEADERS_ONLY)
        target_compile_options(${project_name} INTERFACE ${PROJECT_WARNINGS})
    else ()
        target_compile_options(${project_name} PUBLIC ${PROJECT_WARNINGS})
    endif ()

    if (NOT TARGET ${project_name})
        message(AUTHOR_WARNING "${project_name} is not a target, \
            thus no compiler warning were added.")
    endif ()

endfunction ()

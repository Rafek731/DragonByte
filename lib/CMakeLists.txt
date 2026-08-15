add_library(problem_lib
    "${CMAKE_CURRENT_LIST_DIR}/problem.cpp"
)

target_include_directories(problem_lib
    PUBLIC
        "${CMAKE_SOURCE_DIR}/lib"
)

set_target_properties(problem_lib PROPERTIES LINKER_LANGUAGE CXX)

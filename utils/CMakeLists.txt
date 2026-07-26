add_library(solution_lib
    "${CMAKE_CURRENT_LIST_DIR}/Solution.hpp"
)

target_include_directories(solution_lib
    INTERFACE
        "${CMAKE_SOURCE_DIR}"
)

set_target_properties(solution_lib PROPERTIES LINKER_LANGUAGE CXX)

# check
add_executable(2026_qual_kitchen_duty_roster_check
    "${CMAKE_CURRENT_LIST_DIR}/src/check.cpp"
)

set_target_properties(2026_qual_kitchen_duty_roster_check
    PROPERTIES
        OUTPUT_NAME kitchen_duty_roster_check
)

# solve
add_executable(2026_qual_kitchen_duty_roster_solve
    "${CMAKE_CURRENT_LIST_DIR}/src/solve.cpp"
)

set_target_properties(2026_qual_kitchen_duty_roster_solve
    PROPERTIES
        OUTPUT_NAME kitchen_duty_roster_solve
)

target_link_libraries(2026_qual_kitchen_duty_roster_solve
    PRIVATE
        problem_lib
)

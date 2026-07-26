cmake_minimum_required(VERSION 4.2.3)

project(DragonByte)

set(CXX_STANDARD 23)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}")

add_subdirectory(utils)
add_subdirectory(competitions)

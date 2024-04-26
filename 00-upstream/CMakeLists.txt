cmake_minimum_required(VERSION 3.16)

project(zero
  VERSION 0.1.0
  DESCRIPTION "An example library and executable, with tests."
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)

find_package(cupcake.cmake REQUIRED)

cupcake_project()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS OFF)

# These are special functions expecting a `cupcake.json`.
# They are called in this template to test that
# they quietly return if the file is missing.
cupcake_find_packages(main)
cupcake_link_libraries(zero.imports.main INTERFACE main)

cupcake_add_library(zero)

cupcake_add_executable(true)
target_link_libraries(${this} PRIVATE zero::libzero)

cupcake_enable_testing()

cupcake_install_project()

cupcake_install_cpp_info()

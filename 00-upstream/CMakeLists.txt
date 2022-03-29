cmake_minimum_required(VERSION 3.7)

project(zero
  VERSION 0.1.0
  DESCRIPTION "An example library and executable, with tests."
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

include(cupcake)

cupcake_project()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_FIND_PACKAGE_SORT_ORDER NATURAL)
set(CMAKE_FIND_PACKAGE_SORT_DIRECTION DEC)
# dependencies {
cupcake_find_package(doctest 2.4 PRIVATE)
# }

cupcake_add_library(zero)

cupcake_add_executable(true)
target_link_libraries(${this} PRIVATE zero::libzero)

cupcake_add_tests()

cupcake_install_project()

cmake_minimum_required(VERSION 3.11)

set(PROJECT_DESCRIPTION "\
An example project that imports another through FetchContent, \
which itself imports yet another through add_subdirectory.\
")

project(seven
  VERSION 0.1.0
  DESCRIPTION "${PROJECT_DESCRIPTION}"
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/external")
# TODO: Import Cupcake CMake modules from an installed package.
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../00-upstream/cmake")

include(cupcake)

cupcake_project()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_FIND_PACKAGE_SORT_ORDER NATURAL)
set(CMAKE_FIND_PACKAGE_SORT_DIRECTION DEC)
# dependencies {
cupcake_find_package(doctest 2.4 PRIVATE)
cupcake_find_package(two 0.1)
# }

cupcake_add_library(seven)
target_link_libraries(${this} PRIVATE two::libtwo)

cupcake_add_executable(seven)
target_link_libraries(${this} PRIVATE seven::libseven)

cupcake_add_tests()

cupcake_install_project()

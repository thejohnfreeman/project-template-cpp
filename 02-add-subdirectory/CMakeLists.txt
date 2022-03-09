cmake_minimum_required(VERSION 3.7)

project(two
  VERSION 0.1.0
  DESCRIPTION "An example project that imports another through add_subdirectory."
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)

# TODO: Import Cupcake CMake modules from an installed package.
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../00-upstream/cmake")

include(cupcake)

cupcake_project()

set(CMAKE_FIND_PACKAGE_SORT_ORDER NATURAL)
set(CMAKE_FIND_PACKAGE_SORT_DIRECTION DEC)
# dependencies {
cupcake_find_package(doctest 2.4 PRIVATE)
# }

add_subdirectory(external)
add_subdirectory(include)
add_subdirectory(src)
enable_testing()
add_subdirectory(tests)

cupcake_install_project()

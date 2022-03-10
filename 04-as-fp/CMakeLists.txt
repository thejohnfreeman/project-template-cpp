cmake_minimum_required(VERSION 3.7)

set(PROJECT_DESCRIPTION "\
An example project that imports another through find_package, \
which itself imported yet another through add_subdirectory.\
")

project(four
  VERSION 0.1.0
  DESCRIPTION "${PROJECT_DESCRIPTION}"
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)

# TODO: Import Cupcake CMake modules from an installed package.
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../00-upstream/cmake")

include(cupcake)

cupcake_project()

set(CMAKE_FIND_PACKAGE_SORT_ORDER NATURAL)
set(CMAKE_FIND_PACKAGE_SORT_DIRECTION DEC)
# To test transitive dependencies in package configuration files,
# we must depend on package two without directly depending on package zero.
# dependencies {
cupcake_find_package(doctest 2.4 PRIVATE)
cupcake_find_package(two 0.1)
# }

add_subdirectory(include)
add_subdirectory(src)
enable_testing()
add_subdirectory(tests)

cupcake_install_project()

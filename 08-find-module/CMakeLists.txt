cmake_minimum_required(VERSION 3.11)

set(PROJECT_DESCRIPTION "\
An example project that imports another through a Find Module \
that tries, in order, to (1) find a configuration file, (2) find installed \
artifacts, or (3) download the dependency with FetchContent.\
")

project(eight
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

set(CMAKE_FIND_PACKAGE_SORT_ORDER NATURAL)
set(CMAKE_FIND_PACKAGE_SORT_DIRECTION DEC)
# dependencies {
cupcake_find_package(doctest 2.4 PRIVATE)
cupcake_find_package(zero 0.1)
# }

add_subdirectory(include)
add_subdirectory(src)
enable_testing()
add_subdirectory(tests)

cupcake_install_project()
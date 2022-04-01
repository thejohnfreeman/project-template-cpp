cmake_minimum_required(VERSION 3.7)

project(ten
  VERSION 0.1.0
  DESCRIPTION "An example project that imports another through Conan."
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)

# TODO: Import Cupcake CMake modules from an installed package.
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../00-upstream/cmake")

include(cupcake)

cupcake_project()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS OFF)

# dependencies {
cupcake_find_package(doctest 2.4 PRIVATE)
cupcake_find_package(zero 0.1)
# }

cupcake_add_library(ten)
target_link_libraries(${this} PUBLIC zero::libzero)

cupcake_add_executable(ten)
target_link_libraries(${this} PUBLIC ten::libten)

cupcake_add_tests()

cupcake_install_project()

cmake_minimum_required(VERSION 3.16)

project(nine
  VERSION 0.1.0
  DESCRIPTION "An example project that imports another through ExternalProject."
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)

find_package(cupcake 0.3 REQUIRED)

cupcake_project()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS OFF)

# dependencies {
cupcake_find_package(zero 0.1)
# }

cupcake_add_library(nine)

cupcake_add_executable(nine)
target_link_libraries(${this} PRIVATE
  zero::libzero
  nine::libnine
)

cupcake_add_tests()

cupcake_install_project()

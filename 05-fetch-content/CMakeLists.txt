cmake_minimum_required(VERSION 3.21)

project(five
  VERSION 0.1.0
  DESCRIPTION "An example project that imports another through FetchContent."
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)

find_package(cupcake.cmake REQUIRED)

cupcake_project()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS OFF)

# dependencies {
cupcake_find_package(zero)
# }

cupcake_add_library(five)

cupcake_add_executable(five)
target_link_libraries(${this} PRIVATE
  zero::libzero
  five::libfive
)

cupcake_enable_testing()

cupcake_install_project()

cmake_minimum_required(VERSION 3.21)

project(nine
  VERSION 0.1.0
  DESCRIPTION "An example project that imports another through ExternalProject."
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

cupcake_add_library(nine)

cupcake_add_executable(nine)
target_link_libraries(${this} PRIVATE
  zero::library
  nine.library
)

cupcake_enable_testing()

cupcake_install_project()

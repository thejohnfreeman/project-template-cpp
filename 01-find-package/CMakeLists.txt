cmake_minimum_required(VERSION 3.16)

project(one
  VERSION 0.1.0
  DESCRIPTION "An example project that imports another through find_package."
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)

find_package(cupcake REQUIRED)

cupcake_project()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS OFF)

# dependencies {
cupcake_find_package(zero)
# }

target_link_libraries(one.imports.main INTERFACE
  zero::libzero
)

cupcake_add_library(one)
target_link_libraries(${this} PUBLIC one.imports.main)

cupcake_add_executable(hello)
target_link_libraries(${this} PRIVATE one.libone)

cupcake_enable_testing()

cupcake_install_project()

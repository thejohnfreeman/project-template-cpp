cmake_minimum_required(VERSION 3.21)

project(ten
  VERSION 0.1.0
  DESCRIPTION "An example project that calls special Cupcake functions."
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)

find_package(cupcake.cmake REQUIRED)

cupcake_project()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS OFF)

cupcake_find_packages(main)
cupcake_link_libraries(ten.imports.main INTERFACE main)

# Test default argument.
cupcake_add_libraries()
cupcake_add_executables()

cupcake_enable_testing()

add_subdirectory(examples)

cupcake_install_project()

# external libraries
cupcake_assert(TARGET zero::libraries) # all libraries
cupcake_assert(TARGET zero::libraries::zero) # named library (long)
cupcake_assert(TARGET zero::l::zero) # named library (short)
cupcake_assert(TARGET zero::library) # main library

# external executables
# cupcake_assert(TARGET zero::executables) # all executables?
# cupcake_assert(TARGET zero::executables::zero) # named executable (long) # TODO
# cupcake_assert(TARGET zero::e::zero) # named executable (short) # TODO
# cupcake_assert(TARGET zero::executable) # main executable # TODO

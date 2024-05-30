cmake_minimum_required(VERSION 3.21)

project(one
  VERSION 0.1.0
  DESCRIPTION "An example project that imports another through find_package."
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

target_link_libraries(one.imports.main INTERFACE
  zero::library
)

cupcake_add_library(one)
target_link_libraries(${this} PUBLIC one.imports.main)

cupcake_add_executable(hello)
target_link_libraries(${this} PRIVATE one.l.one)

cupcake_enable_testing()

cupcake_install_project()

# external libraries
cupcake_assert(TARGET zero::libraries) # all libraries
cupcake_assert(TARGET zero::libraries::zero) # named library (long)
cupcake_assert(TARGET zero::l::zero) # named library (short)
cupcake_assert(TARGET zero::library) # main library

# external executables
# cupcake_assert(TARGET zero::executables) # all executables?
cupcake_assert(TARGET zero::executables::zero) # named executable (long)
cupcake_assert(TARGET zero::e::zero) # named executable (short)
cupcake_assert(TARGET zero::executable) # main executable

# external variables
cupcake_assert(zero_LIBRARY_NAMES STREQUAL "zero")
# <package>_LIBRARIES is the CMake convention.
# See: FindBoost, FindProtobuf, FindOpenSSL, etc.
# We can only assert that the variable is defined and is a list of targets.
cupcake_assert(zero_LIBRARIES STREQUAL "zero::libraries::zero")
cupcake_assert(zero_EXECUTABLE_NAMES STREQUAL "zero\;true")
cupcake_assert(zero_EXECUTABLES STREQUAL "zero::executables::zero\;zero::executables::true")

cmake_minimum_required(VERSION 3.21)

project(zero
  VERSION 0.1.0
  DESCRIPTION "An example library and executable, with tests."
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)

find_package(cupcake.cmake REQUIRED)

cupcake_project()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS OFF)

# These are special functions expecting a `cupcake.json`.
# They are called in this template to test that
# they quietly return if the file is missing.
cupcake_find_packages(main)
cupcake_link_libraries(zero.imports.main INTERFACE main)

cupcake_add_library(zero)

cupcake_add_executable(zero)
target_link_libraries(${this} PRIVATE zero.l.zero)

cupcake_add_executable(true)
target_link_libraries(${this} PRIVATE zero.l.zero)

cupcake_enable_testing()

cupcake_install_project()

cupcake_install_cpp_info()

# internal libraries for named project
cupcake_assert(NOT TARGET zero.libzero) # deprecated
cupcake_assert(TARGET zero.libraries) # all libraries
cupcake_assert(TARGET zero.libraries.zero) # named library (long)
cupcake_assert(TARGET zero.l.zero) # named library (short)
cupcake_assert(TARGET zero.library) # main library

if(PROJECT_IS_TOP_LEVEL)
  # internal libraries for root project
  cupcake_assert(TARGET libraries) # all libraries
  cupcake_assert(TARGET libraries.zero) # named library (long)
  cupcake_assert(TARGET l.zero) # named library (short)
  cupcake_assert(TARGET library) # main library
endif()

# external libraries
cupcake_assert(NOT TARGET zero::libzero) # deprecated
cupcake_assert(TARGET zero::libraries) # all libraries
cupcake_assert(TARGET zero::libraries::zero) # named library (long)
cupcake_assert(TARGET zero::l::zero) # named library (short)
cupcake_assert(TARGET zero::library) # main library

# internal executables for named project
cupcake_assert(NOT TARGET zero.zero)
cupcake_assert(TARGET zero.executables) # all executables
cupcake_assert(TARGET zero.executables.zero) # named executable (long)
cupcake_assert(TARGET zero.e.zero) # named executable (short)
cupcake_assert(TARGET zero.executable) # main executable

if(PROJECT_IS_TOP_LEVEL)
  # internal executables for root project
  cupcake_assert(TARGET executables) # all executables
  cupcake_assert(TARGET executables.zero) # named executable (long)
  cupcake_assert(TARGET e.zero) # named executable (short)
  cupcake_assert(TARGET executable) # main executable
endif()

# external executables
cupcake_assert(NOT TARGET zero::zero)
#cupcake_assert(TARGET zero::executables) # all executables
cupcake_assert(TARGET zero::executables::zero) # named executable (long)
cupcake_assert(TARGET zero::e::zero) # named executable (short)
cupcake_assert(TARGET zero::executable) # main executable

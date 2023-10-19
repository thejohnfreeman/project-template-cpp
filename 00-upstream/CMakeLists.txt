cmake_minimum_required(VERSION 3.16)

project(zero
  VERSION 0.1.0
  DESCRIPTION "An example library and executable, with tests."
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)

find_package(cupcake 0.3 REQUIRED)

cupcake_project()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS OFF)

# dependencies {
# }

cupcake_add_library(zero)

cupcake_add_executable(true)
target_link_libraries(${this} PRIVATE zero::libzero)

cupcake_add_tests()

cupcake_install_project()

cupcake_install_cpp_info()

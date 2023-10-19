cmake_minimum_required(VERSION 3.16)

project(ten
  VERSION 0.1.0
  DESCRIPTION "An example project that imports another through Conan."
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)

find_package(cupcake 0.3 REQUIRED)

cupcake_project()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS OFF)

cupcake_find_conan_packages()

cupcake_add_library(ten)
target_link_libraries(${this} PUBLIC zero::libzero)

cupcake_add_executable(ten)
target_link_libraries(${this} PUBLIC ten::libten)

cupcake_add_tests()

cupcake_install_project()

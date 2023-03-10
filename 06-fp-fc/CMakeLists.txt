cmake_minimum_required(VERSION 3.11)

set(PROJECT_DESCRIPTION "\
An example project that imports another through FetchContent, \
which itself imports yet another through find_package.\
")

project(six
  VERSION 0.1.0
  DESCRIPTION "${PROJECT_DESCRIPTION}"
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)

find_package(cupcake 0.1 REQUIRED)

cupcake_project()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS OFF)

# dependencies {
cupcake_find_package(doctest 2.4 PRIVATE)
cupcake_find_package(one 0.1)
# }

cupcake_add_library(six)
target_link_libraries(${this} PRIVATE one::libone)

cupcake_add_executable(six)
target_link_libraries(${this} PRIVATE six::libsix)

cupcake_add_tests()

cupcake_install_project()

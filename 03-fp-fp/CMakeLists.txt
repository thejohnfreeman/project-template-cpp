cmake_minimum_required(VERSION 3.16)

set(PROJECT_DESCRIPTION "\
An example project that imports another through find_package, \
which itself imports yet another through find_package.\
")

project(three
  VERSION 0.1.0
  DESCRIPTION "${PROJECT_DESCRIPTION}"
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)

find_package(cupcake 0.3 REQUIRED)

cupcake_project()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS OFF)

# To test transitive dependencies in package configuration files,
# we must depend on package one without directly depending on package zero.
# dependencies {
cupcake_find_package(one 0.1)
# }

cupcake_add_library(three)
target_link_libraries(${this} PUBLIC one::libone)

cupcake_add_executable(aloha)
target_link_libraries(${this} PRIVATE one::libone)

cupcake_add_tests()

cupcake_install_project()

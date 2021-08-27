cmake_minimum_required(VERSION 3.7)

# Choose different defaults.
set(CMAKE_EXPORT_COMPILE_COMMANDS YES)

project(greetings
  VERSION 0.1.0
  DESCRIPTION "An example library."
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)

set(CMAKE_FIND_PACKAGE_SORT_ORDER NATURAL)
set(CMAKE_FIND_PACKAGE_SORT_DIRECTION DEC)
# dependencies {
# }

find_package(doctest REQUIRED)

set(PROJECT_EXPORT_SET ${PROJECT_NAME}_targets)

add_subdirectory(include)
add_subdirectory(src)
enable_testing()
add_subdirectory(tests)

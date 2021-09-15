cmake_minimum_required(VERSION 3.7)

# To make things easy for callers, we must normalize some paths that may be
# passed on the command line.
file(TO_CMAKE_PATH "${CMAKE_MODULE_PATH}" CMAKE_MODULE_PATH)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

project(greetings
  VERSION 0.1.0
  DESCRIPTION "An example library."
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)

# Choose different defaults.
set(CMAKE_EXPORT_COMPILE_COMMANDS YES)
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH YES)
include(FutureInstallDirs)

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

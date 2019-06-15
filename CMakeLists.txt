# future requires 3.7
cmake_minimum_required(VERSION 3.7)

set(CMAKE_FIND_PACKAGE_SORT_ORDER NATURAL)
set(CMAKE_FIND_PACKAGE_SORT_DIRECTION DEC)
find_package(future REQUIRED)

project(greetings
  VERSION 0.1.0
  DESCRIPTION "An example library."
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)
future_project(
  LICENSE "ISC"
  AUTHORS "John Freeman <jfreeman08@gmail.com>"
)

future_add_dependency(PRIVATE doctest)

future_add_headers(headers DIRECTORY include)
add_subdirectory(src)
enable_testing()
add_subdirectory(tests)

future_install_project()

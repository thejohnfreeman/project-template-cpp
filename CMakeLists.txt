# future requires 3.7
cmake_minimum_required(VERSION 3.7)

project(greetings
  VERSION 0.1.0
  DESCRIPTION "An example library."
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)

set(CMAKE_FIND_PACKAGE_SORT_ORDER NATURAL)
set(CMAKE_FIND_PACKAGE_SORT_DIRECTION DEC)
find_package(future CONFIG REQUIRED)

future_project(
  LICENSE ISC
  REPOSITORY_URL https://github.com/thejohnfreeman/project-template-cpp.git
  AUTHORS "John Freeman <jfreeman08@gmail.com>"
)

future_add_dependency(PRIVATE doctest)

# We could create `include/CMakeLists.txt` and `add_subdirectory(include)`,
# but it would only have this next line,
# so I've decided to just inline it here.
future_add_headers(headers DIRECTORY include)

add_subdirectory(src)
enable_testing()
add_subdirectory(tests)
add_subdirectory(examples)

future_install_project()

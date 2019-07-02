# future requires 3.7
cmake_minimum_required(VERSION 3.7)

project(english
  VERSION 0.1.0
  DESCRIPTION "An example executable that depends on `greetings`."
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)

set(CMAKE_FIND_PACKAGE_SORT_ORDER NATURAL)
set(CMAKE_FIND_PACKAGE_SORT_DIRECTION DEC)
find_package(future CONFIG REQUIRED)

future_add_dependency(PRIVATE greetings CONFIG)

# If the code necessary for this target were longer,
# we would move it into `src/CMakeLists.txt`.
add_executable(main src/main.cpp)
target_link_libraries(main greetings::greetings)

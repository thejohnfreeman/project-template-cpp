cmake_minimum_required(VERSION 3.16)

set(PROJECT_DESCRIPTION "\
An example project that imports another through FetchContent, \
which itself imports yet another through add_subdirectory.\
")

project(seven
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

# dependencies {
cupcake_find_package(two 0.1)
# }

cupcake_add_library(seven)
target_link_libraries(${this} PRIVATE two::libtwo)

cupcake_add_executable(seven)
target_link_libraries(${this} PRIVATE seven::libseven)

cupcake_add_tests()

cupcake_install_project()

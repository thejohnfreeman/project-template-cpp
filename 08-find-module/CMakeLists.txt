cmake_minimum_required(VERSION 3.16)

set(PROJECT_DESCRIPTION "\
An example project that imports another through a Find Module \
that tries, in order, to (1) find a configuration file, (2) find installed \
artifacts, or (3) download the dependency with FetchContent.\
")

project(eight
  VERSION 0.1.0
  DESCRIPTION "${PROJECT_DESCRIPTION}"
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)

find_package(cupcake REQUIRED)

cupcake_project()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS OFF)

# dependencies {
cupcake_find_package(zero)
# }

cupcake_add_library(eight)

cupcake_add_executable(eight)
target_link_libraries(${this} PRIVATE
  zero::libzero
  eight::libeight
)

cupcake_enable_testing()

cupcake_install_project()

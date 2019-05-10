cmake_minimum_required(VERSION 3.1)
project(project_template VERSION 0.1.0 LANGUAGES CXX)

find_package(future REQUIRED)
find_package(doctest REQUIRED)
include(GNUInstallDirs)

add_subdirectory(include)
add_subdirectory(src)
enable_testing()
add_subdirectory(tests)

install_project()

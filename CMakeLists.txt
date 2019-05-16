# 3.12 for --build --parallel.
cmake_minimum_required(VERSION 3.12)
file(READ version VERSION)
string(STRIP ${VERSION} VERSION)
project(project_template VERSION ${VERSION} LANGUAGES CXX)

find_package(future REQUIRED)
future_add_dependency(PRIVATE doctest)

future_add_headers(${PROJECT_NAME}_headers DIRECTORY include)
add_subdirectory(src)
enable_testing()
add_subdirectory(tests)

future_install_project()

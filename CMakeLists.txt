# 3.12 for --build --parallel.
cmake_minimum_required(VERSION 3.12)
project(project_template VERSION 0.1.0 LANGUAGES CXX)

find_package(future REQUIRED)
future_add_dependency(PRIVATE doctest)

future_add_headers(${PROJECT_NAME}_headers DIRECTORY include)
add_subdirectory(src)
enable_testing()
add_subdirectory(tests)

future_install_project()

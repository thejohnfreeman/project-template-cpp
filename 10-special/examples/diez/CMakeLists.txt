cmake_minimum_required(VERSION 3.16)

project(diez
  VERSION 0.1.0
  LANGUAGES CXX
)

find_package(cupcake REQUIRED)

cupcake_project()

cupcake_find_packages(main)
cupcake_link_libraries(${PROJECT_NAME}.imports.main INTERFACE main)

cupcake_add_libraries(main)
cupcake_add_executables(main)

cupcake_enable_testing()

cupcake_install_project()
cupcake_install_cpp_info()

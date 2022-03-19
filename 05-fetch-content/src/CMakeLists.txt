cupcake_add_library(five library.cpp)

cupcake_add_executable(five main.cpp)
target_link_libraries(${this} PRIVATE zero::library ${PROJECT_NAME}::library)

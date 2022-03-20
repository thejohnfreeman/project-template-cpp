cupcake_add_library(nine library.cpp)

cupcake_add_executable(nine main.cpp)
target_link_libraries(${this} PRIVATE zero::library ${PROJECT_NAME}::library)

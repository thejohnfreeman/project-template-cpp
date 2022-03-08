cupcake_add_library(one one.cpp)

cupcake_add_executable(hello hello.cpp)
target_link_libraries(${this} PRIVATE ${PROJECT_NAME}::library)

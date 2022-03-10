cupcake_add_library(libseven library.cpp)
target_link_libraries(${this} PRIVATE two::library)

cupcake_add_executable(seven main.cpp)
target_link_libraries(${this} PRIVATE ${PROJECT_NAME}::library)

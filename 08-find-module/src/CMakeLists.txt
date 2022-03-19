cupcake_add_library(eight library.cpp)

cupcake_add_executable(eight main.cpp)
target_link_libraries(${this} PRIVATE zero::library ${PROJECT_NAME}::library)

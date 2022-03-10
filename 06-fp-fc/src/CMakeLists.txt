cupcake_add_library(libsix library.cpp)
target_link_libraries(${this} PRIVATE one::library)

cupcake_add_executable(six main.cpp)
target_link_libraries(${this} PRIVATE ${PROJECT_NAME}::library)

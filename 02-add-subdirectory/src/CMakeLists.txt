cupcake_add_library(two two.cpp)

cupcake_add_executable(goodbye goodbye.cpp)
target_link_libraries(${this} PRIVATE zero::library)

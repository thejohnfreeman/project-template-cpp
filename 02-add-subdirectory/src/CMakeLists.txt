cupcake_add_library(two two.cpp)
target_link_libraries(${this} PUBLIC zero::library)

cupcake_add_executable(goodbye goodbye.cpp)
target_link_libraries(${this} PRIVATE zero::library)

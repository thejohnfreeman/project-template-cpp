cupcake_add_library(three three.cpp)
target_link_libraries(${this} PUBLIC one::library)

cupcake_add_executable(aloha aloha.cpp)
target_link_libraries(${this} PRIVATE one::library)

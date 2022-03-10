cupcake_add_library(libfour library.cpp)
target_link_libraries(${this} PUBLIC two::library)

cupcake_add_executable(four main.cpp)
target_link_libraries(${this} PUBLIC ${PROJECT_NAME}::library)

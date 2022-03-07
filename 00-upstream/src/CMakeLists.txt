cupcake_add_library(zero)
target_sources(${this} PRIVATE zero.cpp)

cupcake_add_executable(true)
target_sources(${this} PRIVATE true.cpp)
target_link_libraries(${this} PRIVATE ${PROJECT_NAME}::library)

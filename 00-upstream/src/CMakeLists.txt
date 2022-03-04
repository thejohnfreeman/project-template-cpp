cupcake_add_library(library)
target_sources(${this} PRIVATE greetings.cpp)

cupcake_add_executable(executable)
target_sources(${this} PRIVATE greet.cpp)
target_link_libraries(${this} PRIVATE ${PROJECT_NAME}::library)

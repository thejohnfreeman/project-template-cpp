cupcake_add_library(greetings)
target_sources(${this} PRIVATE greetings.cpp)

cupcake_add_executable(greet)
target_sources(${this} PRIVATE greet.cpp)
target_link_libraries(${this} PRIVATE ${PROJECT_NAME}::greetings)

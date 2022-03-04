include(cupcake_add_test_executable)

cupcake_add_test_executable(greetings greetings.cpp)
target_link_libraries(
  ${this}
  ${PROJECT_NAME}::library
  doctest::doctest
)

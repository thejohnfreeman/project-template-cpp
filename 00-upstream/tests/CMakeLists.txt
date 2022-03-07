cupcake_add_test_executable(greetings greetings.cpp)
target_link_libraries(
  ${this}
  ${PROJECT_NAME}::library
  doctest::doctest
)

cupcake_add_test_executable(version version.cpp)
target_link_libraries(
  ${this}
  ${PROJECT_NAME}::headers
  doctest::doctest
)

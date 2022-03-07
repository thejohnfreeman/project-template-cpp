cupcake_add_test_executable(version version.cpp)
target_link_libraries(
  ${this}
  greetings::headers
  doctest::doctest
)

cupcake_add_test_executable(five five.cpp)
target_link_libraries(
  ${this}
  five::libfive
  doctest::doctest
)

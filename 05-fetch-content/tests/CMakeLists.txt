cupcake_add_test_executable(five)
target_link_libraries(
  ${this}
  five::libfive
  doctest::doctest
)

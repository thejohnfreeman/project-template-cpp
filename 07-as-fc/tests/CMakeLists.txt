cupcake_add_test_executable(seven)
target_link_libraries(
  ${this}
  seven::libseven
  doctest::doctest
)

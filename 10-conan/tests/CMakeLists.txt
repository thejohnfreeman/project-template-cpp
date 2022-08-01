cupcake_add_test_executable(ten)
target_link_libraries(
  ${this}
  ten::libten
  doctest::doctest
)

cupcake_add_test_executable(boolean)
target_link_libraries(
  ${this}
  ten::libten
  doctest::doctest
)

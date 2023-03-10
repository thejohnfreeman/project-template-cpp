cupcake_find_package(doctest 2.4 PRIVATE)

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

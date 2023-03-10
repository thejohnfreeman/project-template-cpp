cupcake_find_package(doctest 2.4 PRIVATE)

cupcake_add_test_executable(two)
target_link_libraries(
  ${this}
  two::libtwo
  doctest::doctest
)

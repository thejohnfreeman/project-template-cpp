cupcake_find_package(doctest PRIVATE)

cupcake_add_test(five)
target_link_libraries(
  ${this}
  five::libfive
  doctest::doctest
)

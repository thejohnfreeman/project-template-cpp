cupcake_find_package(doctest PRIVATE)

cupcake_add_test(three)
target_link_libraries(
  ${this}
  three.library
  doctest::doctest
)

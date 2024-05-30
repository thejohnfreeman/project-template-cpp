cupcake_find_package(doctest PRIVATE)

cupcake_add_test(nine)
target_link_libraries(
  ${this}
  nine.library
  doctest::doctest
)

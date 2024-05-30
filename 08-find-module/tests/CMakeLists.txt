cupcake_find_package(doctest PRIVATE)

cupcake_add_test(eight)
target_link_libraries(
  ${this}
  eight.library
  doctest::doctest
)

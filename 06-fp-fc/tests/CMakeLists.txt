cupcake_find_package(doctest PRIVATE)

cupcake_add_test(six)
target_link_libraries(
  ${this}
  six::libsix
  doctest::doctest
)

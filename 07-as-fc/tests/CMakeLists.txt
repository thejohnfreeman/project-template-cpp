cupcake_find_package(doctest PRIVATE)

cupcake_add_test(seven)
target_link_libraries(
  ${this}
  seven::libseven
  doctest::doctest
)

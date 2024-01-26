cupcake_find_package(doctest PRIVATE)

cupcake_add_test(one)
target_link_libraries(
  ${this}
  one::libone
)

cupcake_add_test(boolean)
target_link_libraries(
  ${this}
  one::libone
)

cupcake_add_test(version)
target_link_libraries(
  ${this}
  zero::libzero
)

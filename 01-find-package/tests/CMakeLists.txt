cupcake_find_package(doctest PRIVATE)

cupcake_add_test(one)
target_link_libraries(
  ${this}
  one.library
)

cupcake_add_test(boolean)
target_link_libraries(
  ${this}
  one.library
)

cupcake_add_test(version)
target_link_libraries(
  ${this}
  zero::library
)

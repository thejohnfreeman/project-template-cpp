cupcake_find_package(doctest 2.4 PRIVATE)

cupcake_add_test_executable(zero)
target_link_libraries(
  ${this}
  zero::libzero
)

cupcake_add_test_executable(boolean)
target_link_libraries(
  ${this}
  zero::libzero
)

cupcake_add_test_executable(version)
target_link_libraries(
  ${this}
  zero::libzero
)

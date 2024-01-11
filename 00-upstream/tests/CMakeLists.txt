cupcake_find_packages(test PRIVATE)
cupcake_link_libraries(zero.dependencies.test INTERFACE test)

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

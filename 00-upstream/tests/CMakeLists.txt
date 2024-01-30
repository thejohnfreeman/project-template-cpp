# These are special functions expecting a `cupcake.json`.
# They are called in this template to test that
# they quietly return if the file is missing.
cupcake_find_packages(test PRIVATE)
cupcake_link_libraries(zero.imports.test INTERFACE test)

cupcake_add_test(zero)
target_link_libraries(
  ${this}
  zero::libzero
)

cupcake_add_test(boolean)
target_link_libraries(
  ${this}
  zero::libzero
)

cupcake_add_test(version)
target_link_libraries(
  ${this}
  zero::libzero
)

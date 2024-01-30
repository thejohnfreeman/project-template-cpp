cupcake_find_packages(test PRIVATE)
cupcake_link_libraries(ten.imports.test INTERFACE test)

cupcake_add_test(ten)
target_link_libraries(
  ${this}
  ten.libten
  ten.imports.test
)

cupcake_add_test(boolean)
target_link_libraries(
  ${this}
  ten.libten
  ten.imports.test
)

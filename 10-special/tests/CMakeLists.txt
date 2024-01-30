cupcake_find_packages(test PRIVATE)
cupcake_link_libraries(ten.dependencies.test INTERFACE test)

cupcake_add_test(ten)
target_link_libraries(
  ${this}
  ten.libten
  ten.dependencies.test
)

cupcake_add_test(boolean)
target_link_libraries(
  ${this}
  ten.libten
  ten.dependencies.test
)

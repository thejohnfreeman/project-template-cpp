cupcake_find_package(doctest PRIVATE)

target_link_libraries(two.imports.test INTERFACE
  two::libtwo
  doctest::doctest
)

cupcake_add_test(two)
target_link_libraries(${this} PUBLIC two.imports.test)

cupcake_find_packages(test PRIVATE)
cupcake_link_libraries(ten.imports.test INTERFACE test)
# Test default argument.
cupcake_add_tests()

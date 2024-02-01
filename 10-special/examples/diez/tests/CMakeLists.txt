cupcake_find_packages(test PRIVATE)
cupcake_link_libraries(${PROJECT_NAME}.dependencies.test INTERFACE test)
cupcake_add_tests(test)

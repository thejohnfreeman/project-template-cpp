cupcake_find_package(doctest PRIVATE)

target_link_libraries(two.dependencies.test INTERFACE
  two::libtwo
  doctest::doctest
)

cupcake_add_test_executable(two)
target_link_libraries(${this} PUBLIC two.dependencies.test)

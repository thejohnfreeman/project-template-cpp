cupcake_find_package(doctest 2.4 PRIVATE)

target_link_libraries(${test_dependencies} INTERFACE
  two::libtwo
  doctest::doctest
)

cupcake_add_test_executable(two)
target_link_libraries(${this} PUBLIC two::test_dependencies)

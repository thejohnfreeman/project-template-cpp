cupcake_find_package(doctest 2.4 PRIVATE)

cupcake_add_test_executable(nine)
target_link_libraries(
  ${this}
  nine::libnine
  doctest::doctest
)

cupcake_find_package(doctest PRIVATE)

cupcake_add_test_executable(nine)
target_link_libraries(
  ${this}
  nine::libnine
  doctest::doctest
)

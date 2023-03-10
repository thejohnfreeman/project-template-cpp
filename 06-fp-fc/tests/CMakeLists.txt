cupcake_find_package(doctest 2.4 PRIVATE)

cupcake_add_test_executable(six)
target_link_libraries(
  ${this}
  six::libsix
  doctest::doctest
)

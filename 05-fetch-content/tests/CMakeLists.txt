cupcake_find_package(doctest 2.4 PRIVATE)

cupcake_add_test_executable(five)
target_link_libraries(
  ${this}
  five::libfive
  doctest::doctest
)

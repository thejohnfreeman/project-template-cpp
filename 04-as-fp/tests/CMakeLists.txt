cupcake_find_package(doctest 2.4 PRIVATE)

cupcake_add_test_executable(four)
target_link_libraries(
  ${this}
  four::libfour
  doctest::doctest
)

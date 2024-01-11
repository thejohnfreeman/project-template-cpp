cupcake_find_package(doctest PRIVATE)

cupcake_add_test_executable(four)
target_link_libraries(
  ${this}
  four::libfour
  doctest::doctest
)

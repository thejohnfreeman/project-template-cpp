cupcake_find_package(doctest PRIVATE)

cupcake_add_test_executable(three)
target_link_libraries(
  ${this}
  three::libthree
  doctest::doctest
)

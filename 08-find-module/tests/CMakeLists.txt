cupcake_find_package(doctest 2.4 PRIVATE)

cupcake_add_test_executable(eight)
target_link_libraries(
  ${this}
  eight::libeight
  doctest::doctest
)

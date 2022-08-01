cupcake_add_test_executable(eight)
target_link_libraries(
  ${this}
  eight::libeight
  doctest::doctest
)

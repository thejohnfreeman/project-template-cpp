cupcake_add_test_executable(eight eight.cpp)
target_link_libraries(
  ${this}
  eight::libeight
  doctest::doctest
)

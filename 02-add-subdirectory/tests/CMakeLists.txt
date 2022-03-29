cupcake_add_test_executable(two two.cpp)
target_link_libraries(
  ${this}
  two::libtwo
  doctest::doctest
)

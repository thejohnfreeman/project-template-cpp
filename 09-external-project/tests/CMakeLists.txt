cupcake_add_test_executable(nine nine.cpp)
target_link_libraries(
  ${this}
  nine::libnine
  doctest::doctest
)

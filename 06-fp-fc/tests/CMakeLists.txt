cupcake_add_test_executable(six six.cpp)
target_link_libraries(
  ${this}
  six::libsix
  doctest::doctest
)

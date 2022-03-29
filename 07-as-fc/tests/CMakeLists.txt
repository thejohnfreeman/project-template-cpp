cupcake_add_test_executable(seven seven.cpp)
target_link_libraries(
  ${this}
  seven::libseven
  doctest::doctest
)

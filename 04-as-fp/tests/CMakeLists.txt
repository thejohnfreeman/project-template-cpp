cupcake_add_test_executable(four four.cpp)
target_link_libraries(
  ${this}
  four::libfour
  doctest::doctest
)

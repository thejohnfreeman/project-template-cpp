cupcake_add_test_executable(one one.cpp)
target_link_libraries(
  ${this}
  one::libone
  doctest::doctest
)

cupcake_add_test_executable(boolean boolean.cpp)
target_link_libraries(
  ${this}
  one::libone
  doctest::doctest
)

cupcake_add_test_executable(version version.cpp)
target_link_libraries(
  ${this}
  zero::libzero
  doctest::doctest
)

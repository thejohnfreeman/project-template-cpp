cupcake_add_test_executable(ten ten.cpp)
target_link_libraries(
  ${this}
  ten::libten
  doctest::doctest
)

cupcake_add_test_executable(boolean boolean.cpp)
target_link_libraries(
  ${this}
  ten::libten
  doctest::doctest
)

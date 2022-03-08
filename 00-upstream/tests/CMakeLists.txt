cupcake_add_test_executable(zero zero.cpp)
target_link_libraries(
  ${this}
  ${PROJECT_NAME}::library
  doctest::doctest
)

cupcake_add_test_executable(boolean boolean.cpp)
target_link_libraries(
  ${this}
  ${PROJECT_NAME}::library
  doctest::doctest
)

cupcake_add_test_executable(version version.cpp)
target_link_libraries(
  ${this}
  ${PROJECT_NAME}::library
  doctest::doctest
)

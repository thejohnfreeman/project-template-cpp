cupcake_add_test_executable(eight eight.cpp)
target_link_libraries(
  ${this}
  ${PROJECT_NAME}::library
  doctest::doctest
)

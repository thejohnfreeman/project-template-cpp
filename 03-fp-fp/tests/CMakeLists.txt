cupcake_add_test_executable(three three.cpp)
target_link_libraries(
  ${this}
  ${PROJECT_NAME}::library
  doctest::doctest
)

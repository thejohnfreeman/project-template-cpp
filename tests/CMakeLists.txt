add_executable(test_greetings EXCLUDE_FROM_ALL greetings.cpp)
set_property(TARGET test_greetings PROPERTY CXX_STANDARD 11)
target_link_libraries(
  test_greetings
  ${PROJECT_NAME}::${PROJECT_NAME}
  doctest::doctest
)
add_test(NAME test_greetings COMMAND test_greetings)
set_tests_properties(
  test_greetings PROPERTIES
  FIXTURES_REQUIRED test_greetings_fixture
)

add_test(
  NAME test_greetings_build
  COMMAND
    ${CMAKE_COMMAND}
    --build ${CMAKE_BINARY_DIR}
    --config $<CONFIG>
    --target test_greetings
)
set_tests_properties(test_greetings_build PROPERTIES
  FIXTURES_SETUP test_greetings_fixture
)

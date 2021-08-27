add_executable(tests greetings.cpp)
set_property(TARGET tests PROPERTY CXX_STANDARD 11)
target_link_libraries(
  tests
  ${PROJECT_NAME}::library
  doctest::doctest
)
add_test(NAME tests COMMAND tests)
set_tests_properties(
  tests PROPERTIES
  FIXTURES_REQUIRED test_greetings_fixture
)

add_test(
  NAME test_greetings_build
  COMMAND
    ${CMAKE_COMMAND}
    --build ${CMAKE_BINARY_DIR}
    --config $<CONFIG>
    --target tests
)
set_tests_properties(test_greetings_build PROPERTIES
  FIXTURES_SETUP test_greetings_fixture
)

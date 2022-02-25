add_custom_target(tests)

# Set parameters for adding a test.
# Convention is to name tests after their main source file.
set(test_name test_greetings)
set(test_sources greetings.cpp)

add_executable(${test_name} EXCLUDE_FROM_ALL ${test_sources})
add_test(NAME ${test_name} COMMAND ${test_name})
set_tests_properties(
  ${test_name} PROPERTIES
  FIXTURES_REQUIRED ${test_name}_fixture
)

add_test(
  NAME ${test_name}_build
  COMMAND
    ${CMAKE_COMMAND}
    --build ${CMAKE_BINARY_DIR}
    --config $<CONFIG>
    --target ${test_name}
)
set_tests_properties(${test_name}_build PROPERTIES
  FIXTURES_SETUP ${test_name}_fixture
)

add_dependencies(tests ${test_name})

target_link_libraries(
  ${test_name}
  ${PROJECT_NAME}::library
  doctest::doctest
)

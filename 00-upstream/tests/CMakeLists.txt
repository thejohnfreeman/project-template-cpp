add_custom_target(tests)

function(add_test_executable target)
  add_executable(${target} EXCLUDE_FROM_ALL ${ARGN})
  add_test(NAME ${target} COMMAND ${target})
  set_tests_properties(
    ${target} PROPERTIES
    FIXTURES_REQUIRED ${target}_fixture
  )

  add_test(
    NAME ${target}_build
    COMMAND
      ${CMAKE_COMMAND}
      --build ${CMAKE_BINARY_DIR}
      --config $<CONFIG>
      --target ${target}
  )
  set_tests_properties(${target}_build PROPERTIES
    FIXTURES_SETUP ${target}_fixture
  )

  add_dependencies(tests ${target})
endfunction()

add_test_executable(test_greetings greetings.cpp)
target_link_libraries(
  test_greetings
  ${PROJECT_NAME}::library
  doctest::doctest
)

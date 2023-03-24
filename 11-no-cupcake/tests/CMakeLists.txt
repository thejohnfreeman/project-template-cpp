add_executable(test_eleven eleven.cpp)
target_link_libraries(test_eleven libeleven)
add_test(NAME test_eleven_build COMMAND
  "${CMAKE_COMMAND}"
  --build "${CMAKE_BINARY_DIR}"
  --config "$<CONFIG>"
  --target test_eleven
)
set_tests_properties(test_eleven_build
  PROPERTIES FIXTURES_SETUP test_eleven_fixture
)
add_test(NAME test_eleven COMMAND test_eleven)
set_tests_properties(test_eleven
  PROPERTIES FIXTURES_REQUIRED test_eleven_fixture
)

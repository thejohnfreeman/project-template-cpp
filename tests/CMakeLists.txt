add_test_executable(greeting EXCLUDE_FROM_ALL greeting.cpp)
target_link_libraries(greeting
  project_template::project_template
  doctest::doctest
)

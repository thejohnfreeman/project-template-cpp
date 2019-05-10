future_get_names_with_file_suffix(TESTS ".cpp")
foreach(TEST ${TESTS})
  future_add_test_executable(${TEST} EXCLUDE_FROM_ALL ${TEST}.cpp)
  target_link_libraries(${TEST}
    PRIVATE 
      project_template::project_template
      doctest::doctest
  )
endforeach(TEST ${TESTS})

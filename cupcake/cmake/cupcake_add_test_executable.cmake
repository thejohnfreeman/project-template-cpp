if(DEFINED_CUPCAKE_ADD_TEST_EXECUTABLE)
  return()
endif()
set(DEFINED_CUPCAKE_ADD_TEST_EXECUTABLE TRUE)

add_custom_target(tests)

function(cupcake_add_test_executable name)
  set(target test_${name})
  set(this ${target} PARENT_SCOPE)
  add_executable(${target} EXCLUDE_FROM_ALL ${ARGN})

  file(GLOB_RECURSE sources CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/${name}/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/${name}.cpp"
  )
  target_sources(${target} PRIVATE ${sources})

  # if(PROJECT_IS_TOP_LEVEL)
  if(PROJECT_NAME STREQUAL CMAKE_PROJECT_NAME)
    add_dependencies(tests ${target})
  else()
    # Do not include tests of dependencies added as subdirectories.
    return()
  endif()

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
endfunction()


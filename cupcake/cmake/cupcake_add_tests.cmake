if(DEFINED_CUPCAKE_ADD_TESTS)
  return()
endif()
set(DEFINED_CUPCAKE_ADD_TESTS TRUE)

macro(cupcake_add_tests)
  # Do not add unexported targets when added as a subproject.
  if(PROJECT_NAME STREQUAL CMAKE_PROJECT_NAME)
    include(CTest)
    # Give package builders a means to skip unexported targets.
    if(BUILD_TESTING)
      add_subdirectory(tests)
    endif()
  endif()
endmacro()
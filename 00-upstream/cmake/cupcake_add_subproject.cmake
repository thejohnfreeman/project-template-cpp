if(DEFINED_CUPCAKE_ADD_SUBPROJECT)
  return()
endif()
set(DEFINED_CUPCAKE_ADD_SUBPROJECT TRUE)

include(cupcake_add_dependency)

set(set_subproject_variables
  "${CMAKE_CURRENT_LIST_DIR}/set_subproject_variables.cmake")

# cupcake_add_subproject(<name> [<path>] [PRIVATE] [...])
function(cupcake_add_subproject name)
  cmake_parse_arguments(ARG "PRIVATE" "" "" ${ARGN})
  if(NOT ARG_UNPARSED_ARGUMENTS)
    set(ARG_UNPARSED_ARGUMENTS ${name})
  endif()

  set(CMAKE_PROJECT_${name}_INCLUDE "${set_subproject_variables}")
  add_subdirectory(${ARG_UNPARSED_ARGUMENTS})

  if(ARG_PRIVATE)
    return()
  endif()

  get_property(SUBPROJECT_SOURCE_DIR
    GLOBAL PROPERTY SUBPROJECT_SOURCE_DIR)
  list(GET ARG_UNPARSED_ARGUMENTS 0 path)
  get_filename_component(expected "${path}" ABSOLUTE)
  if(NOT SUBPROJECT_SOURCE_DIR STREQUAL expected)
    message(FATAL_ERROR "Subproject '${name}' not found at '${expected}'.")
  endif()

  get_property(SUBPROJECT_NAME
    GLOBAL PROPERTY SUBPROJECT_NAME)
  get_property(SUBPROJECT_VERSION_MAJOR
    GLOBAL PROPERTY SUBPROJECT_VERSION_MAJOR)
  get_property(SUBPROJECT_VERSION_MINOR
    GLOBAL PROPERTY SUBPROJECT_VERSION_MINOR)
  cupcake_add_dependency(
    ${SUBPROJECT_NAME}
    ${SUBPROJECT_VERSION_MAJOR}.${SUBPROJECT_VERSION_MINOR}
  )
endfunction()

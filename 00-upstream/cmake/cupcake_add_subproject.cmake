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
  message(STATUS "Entering subproject '${name}' depended by '${PROJECT_NAME}'...")
  add_subdirectory(${ARG_UNPARSED_ARGUMENTS})

  if(ARG_PRIVATE)
    return()
  endif()

  list(GET ARG_UNPARSED_ARGUMENTS 0 path)
  get_filename_component(path "${path}" ABSOLUTE)
  get_property(SUBPROJECT_NAME
    DIRECTORY "${path}"
    PROPERTY PROJECT_NAME
  )
  if(NOT SUBPROJECT_NAME STREQUAL name)
    message(FATAL_ERROR "Subproject '${name}' not found at '${path}'.")
  endif()

  get_property(SUBPROJECT_VERSION_MAJOR
    DIRECTORY "${path}"
    PROPERTY PROJECT_VERSION_MAJOR
  )
  get_property(SUBPROJECT_VERSION_MINOR
    DIRECTORY "${path}"
    PROPERTY PROJECT_VERSION_MINOR
  )
  cupcake_add_dependency(
    ${SUBPROJECT_NAME}
    ${SUBPROJECT_VERSION_MAJOR}.${SUBPROJECT_VERSION_MINOR}
  )
endfunction()

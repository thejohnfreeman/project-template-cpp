if(DEFINED_CUPCAKE_ADD_SUBPROJECT)
  return()
endif()
set(DEFINED_CUPCAKE_ADD_SUBPROJECT TRUE)

set(set_subproject_variables
  "${CMAKE_CURRENT_LIST_DIR}/set_subproject_variables.cmake")

function(cupcake_add_subproject path)
  cmake_parse_arguments(ARG "PRIVATE" "PROJECT_NAME" "" ${ARGN})
  if(NOT ARG_PROJECT_NAME)
    set(ARG_PROJECT_NAME ${path})
  endif()

  set(CMAKE_PROJECT_${ARG_PROJECT_NAME}_INCLUDE "${set_subproject_variables}")
  add_subdirectory(${path} ${ARG_UNPARSED_ARGUMENTS})

  if(ARG_PRIVATE)
    return()
  endif()

  get_property(SUBPROJECT_SOURCE_DIR
    GLOBAL PROPERTY SUBPROJECT_SOURCE_DIR)
  set(expected "${CMAKE_CURRENT_LIST_DIR}/${path}")
  if(NOT SUBPROJECT_SOURCE_DIR STREQUAL expected)
    message(FATAL_ERROR "Project '${ARG_PROJECT_NAME}' not found at ${expected}.")
  endif()

  get_property(SUBPROJECT_NAME
    GLOBAL PROPERTY SUBPROJECT_NAME)
  get_property(SUBPROJECT_VERSION_MAJOR
    GLOBAL PROPERTY SUBPROJECT_VERSION_MAJOR)
  get_property(SUBPROJECT_VERSION_MINOR
    GLOBAL PROPERTY SUBPROJECT_VERSION_MINOR)
  set_property(DIRECTORY "${PROJECT_SOURCE_DIR}"
    APPEND PROPERTY PROJECT_DEPENDENCIES
    "${SUBPROJECT_NAME}\;${SUBPROJECT_VERSION_MAJOR}.${SUBPROJECT_VERSION_MINOR}"
  )
endfunction()

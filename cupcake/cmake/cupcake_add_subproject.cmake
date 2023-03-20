include_guard(GLOBAL)

include(cupcake_module_dir)
include(cupcake_project_properties)

# cupcake_add_subproject(<name> [PRIVATE] [<source_dir> [<binary_dir]])
# TODO: I don't think surplus arguments are handled correctly.
function(cupcake_add_subproject name)
  cmake_parse_arguments(ARG "PRIVATE" "" "" ${ARGN})
  list(POP_FRONT ARG_UNPARSED_ARGUMENTS path)
  if(NOT DEFINED path)
    set(path ${name})
  endif()
  get_filename_component(
    path "${path}" ABSOLUTE BASE_DIR "${CMAKE_CURRENT_LIST_DIR}"
  )

  # added in CMake 3.19: cmake_language(DEFER)
  set(
    CMAKE_PROJECT_${name}_INCLUDE
    "${CUPCAKE_MODULE_DIR}/data/set_subproject_variables.cmake"
  )
  message(STATUS "Entering subproject '${name}' depended by '${PROJECT_NAME}'...")
  add_subdirectory("${path}" ${ARG_UNPARSED_ARGUMENTS})

  if(ARG_PRIVATE)
    return()
  endif()

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

  cupcake_set_project_property(
    APPEND PROPERTY PROJECT_DEPENDENCIES
    "${SUBPROJECT_NAME}\\\\;${SUBPROJECT_VERSION_MAJOR}.${SUBPROJECT_VERSION_MINOR}"
  )
endfunction()

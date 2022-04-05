if(DEFINED_CUPCAKE_FIND_PACKAGE)
  return()
endif()
set(DEFINED_CUPCAKE_FIND_PACKAGE TRUE)

include(cupcake_project_properties)

# cupcake_find_package(<package-name> <version> [PRIVATE])
# We cannot scope the call to find_package because we cannot predict which
# variables that it sets need to percolate. Therefore, this must be a macro.
macro(cupcake_find_package name version)
  string(RANDOM cupcake_scope)

  message(STATUS
    "Finding package '${name}' depended by '${PROJECT_NAME}'..."
  )

  cmake_parse_arguments(${cupcake_scope} "PRIVATE" "" "" ${ARGN})

  # if(PROJECT_IS_TOP_LEVEL AND ...)
  if(PROJECT_NAME STREQUAL CMAKE_PROJECT_NAME AND NOT ${cupcake_scope}_PRIVATE)
    cupcake_set_project_property(
      APPEND PROPERTY PROJECT_DEPENDENCIES "${name}\\\\;${version}"
    )
  endif()

  find_package(${name} ${version} REQUIRED ${${cupcake_scope}_UNPARSED_ARGUMENTS})
  if(NOT ${name}_FOUND)
    message(FATAL_ERROR "Package '${name}' was not found.")
  endif()
endmacro()

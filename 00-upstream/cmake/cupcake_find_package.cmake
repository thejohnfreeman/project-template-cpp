if(DEFINED_CUPCAKE_FIND_PACKAGE)
  return()
endif()
set(DEFINED_CUPCAKE_FIND_PACKAGE TRUE)

# cupcake_find_package(<package-name> <version> [PRIVATE])
function(cupcake_find_package name version)
  cmake_parse_arguments(ARG "PRIVATE" "" "" ${ARGN})

  # if(PROJECT_IS_TOP_LEVEL AND ...)
  if(PROJECT_NAME STREQUAL CMAKE_PROJECT_NAME AND NOT ARG_PRIVATE)
    set_property(DIRECTORY "${PROJECT_SOURCE_DIR}"
      APPEND PROPERTY PROJECT_DEPENDENCIES "${name}\;${version}")
  endif()

  find_package(${name} ${version} REQUIRED ${ARG_UNPARSED_ARGUMENTS})
endfunction()

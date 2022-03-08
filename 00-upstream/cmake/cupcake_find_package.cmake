if(DEFINED_CUPCAKE_FIND_PACKAGE)
  return()
endif()
set(DEFINED_CUPCAKE_FIND_PACKAGE TRUE)

set_property(GLOBAL PROPERTY CUPCAKE_PROJECT_DEPENDENCIES "")

function(cupcake_find_package name version)
  cmake_parse_arguments(ARG "PRIVATE" "" "" ${ARGN})

  # if(PROJECT_IS_TOP_LEVEL AND ...)
  if(PROJECT_NAME STREQUAL CMAKE_PROJECT_NAME AND NOT ARG_PRIVATE)
    set_property(GLOBAL APPEND PROPERTY CUPCAKE_PROJECT_DEPENDENCIES "${name}\;${version}")
  endif()

  find_package(${name} ${version} REQUIRED ${ARG_UNPARSED_ARGUMENTS})
endfunction()

if(DEFINED_CUPCAKE_FIND_PACKAGE)
  return()
endif()
set(DEFINED_CUPCAKE_FIND_PACKAGE TRUE)

include(cupcake_add_dependency)

# cupcake_find_package(<package-name> <version> [PRIVATE])
function(cupcake_find_package name version)
  message(STATUS "Finding package '${name}' depended by '${PROJECT_NAME}'...")

  cmake_parse_arguments(ARG "PRIVATE" "" "" ${ARGN})

  # if(PROJECT_IS_TOP_LEVEL AND ...)
  if(PROJECT_NAME STREQUAL CMAKE_PROJECT_NAME AND NOT ARG_PRIVATE)
    cupcake_add_dependency(${name} ${version})
  endif()

  find_package(${name} ${version} REQUIRED ${ARG_UNPARSED_ARGUMENTS})
endfunction()

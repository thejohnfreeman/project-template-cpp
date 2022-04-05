if(DEFINED_CUPCAKE_GENERATE_VERSION_HEADER)
  return()
endif()
set(DEFINED_CUPCAKE_GENERATE_VERSION_HEADER TRUE)

set(version_header_input "${CMAKE_CURRENT_LIST_DIR}/data/version.hpp.in")

function(cupcake_generate_version_header name)
  cmake_parse_arguments(ARG "" "EXPORT_FILE_NAME" "" ${ARGN})
  if(NOT ARG_EXPORT_FILE_NAME)
    set(ARG_EXPORT_FILE_NAME
      "${CMAKE_INCLUDE_OUTPUT_DIRECTORY}/${name}/version.hpp")
  endif()
  string(TOUPPER ${name} UPPER_NAME)
  configure_file("${version_header_input}" "${ARG_EXPORT_FILE_NAME}")
endfunction()

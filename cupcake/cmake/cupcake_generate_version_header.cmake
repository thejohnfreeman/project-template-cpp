include_guard(GLOBAL)

include(cupcake_module_dir)

function(cupcake_generate_version_header name)
  cmake_parse_arguments(ARG "" "EXPORT_FILE_NAME" "" ${ARGN})
  if(NOT ARG_EXPORT_FILE_NAME)
    set(ARG_EXPORT_FILE_NAME
      "${CMAKE_INCLUDE_OUTPUT_DIRECTORY}/${name}/version.hpp")
  endif()
  string(TOUPPER ${name} UPPER_NAME)
  configure_file(
    "${CUPCAKE_MODULE_DIR}/data/version.hpp.in"
    "${ARG_EXPORT_FILE_NAME}"
  )
endfunction()

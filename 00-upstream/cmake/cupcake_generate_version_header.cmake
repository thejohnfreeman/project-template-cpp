if(DEFINED_CUPCAKE_GENERATE_VERSION_HEADER)
  return()
endif()
set(DEFINED_CUPCAKE_GENERATE_VERSION_HEADER TRUE)

set(version_header_input "${CMAKE_CURRENT_LIST_DIR}/version.hpp.in")

function(cupcake_generate_version_header)
  cmake_parse_arguments(GVH "" "EXPORT_FILE_NAME" "")
  if(NOT GVH_EXPORT_FILE_NAME)
    set(GVH_EXPORT_FILE_NAME
      "${PROJECT_BINARY_DIR}/include/generated/${PROJECT_NAME}/version.hpp")
  endif()
  string(TOUPPER ${PROJECT_NAME} UPPER_PROJECT_NAME)
  configure_file("${version_header_input}" "${GVH_EXPORT_FILE_NAME}")
endfunction()

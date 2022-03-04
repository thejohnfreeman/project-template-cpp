if(DEFINED_CUPCAKE_ADD_LIBRARY)
  return()
endif()
set(DEFINED_CUPCAKE_ADD_LIBRARY TRUE)

include(GenerateExportHeader)
include(GNUInstallDirs)

function(cupcake_add_library name)
  set(target ${PROJECT_NAME}_${name})
  set(this ${target} PARENT_SCOPE)
  add_library(${target} ${ARGN})
  set_target_properties(${target} PROPERTIES
    OUTPUT_NAME ${name}
    EXPORT_NAME ${name}
  )
  add_library(${PROJECT_NAME}::${name} ALIAS ${target})
  # Let the library include "private" headers if it wants.
  target_include_directories(${target}
    PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}"
  )
  # Each project has only one header library,
  # and every binary library depends on it.
  target_link_libraries(${target} PUBLIC ${PROJECT_NAME}::headers)

  # Add a convenient target for the first top-level library.
  if(${PROJECT_NAME} STREQUAL ${CMAKE_PROJECT_NAME} AND NOT TARGET library)
    add_custom_target(library DEPENDS ${target})
  endif()

  # In order to include the generated header by a path starting with a directory
  # matching the package name like all other package headers, we must pass the
  # `EXPORT_FILE_NAME` option.
  if(NOT ${PROJECT_NAME}_GENERATED_EXPORT_HEADER)
    generate_export_header(${target}
      BASE_NAME ${PROJECT_NAME}
      EXPORT_FILE_NAME "${PROJECT_BINARY_DIR}/generated/include/${PROJECT_NAME}/export.hpp"
    )
    set(${PROJECT_NAME}_GENERATED_EXPORT_HEADER TRUE)
  endif()
  target_include_directories(${target}
    PUBLIC "$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/generated/include>"
  )
  install(
    DIRECTORY "${PROJECT_BINARY_DIR}/generated/include/"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
  )

  get_target_property(library_type ${target} TYPE)
  if(NOT library_type STREQUAL SHARED_LIBRARY)
    # Disable the export definitions for non-shared libraries.
    string(TOUPPER ${PROJECT_NAME} UPPER_PROJECT_NAME)
    target_compile_definitions(${target}
      PUBLIC ${UPPER_PROJECT_NAME}_STATIC_DEFINE
    )
  endif()

  install(
    TARGETS ${target}
    EXPORT ${PROJECT_EXPORT_SET}
    ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
    LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
  )
endfunction()
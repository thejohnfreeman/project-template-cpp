if(DEFINED_CUPCAKE_ADD_LIBRARY)
  return()
endif()
set(DEFINED_CUPCAKE_ADD_LIBRARY TRUE)

include(cupcake_generate_version_header)
include(cupcake_project_properties)
include(GenerateExportHeader)
include(GNUInstallDirs)

# add_library(<name> [<source>...])
function(cupcake_add_library name)
  # We add a "lib" prefix to library targets
  # so that libraries and executables can share the same name.
  # They will be distinguished in the filesystem by their filename prefix
  # and suffix, and within CMake by this prefix.
  set(target ${PROJECT_NAME}_lib${name})
  set(this ${target} PARENT_SCOPE)

  # If this is a header-only library, then it must have type INTERFACE.
  # Otherwise, let the builder choose its linkage with BUILD_SHARED_LIBS.
  if(
      EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/src/lib${name}" OR
      EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/src/lib${name}.cpp"
  )
    unset(type)
    set(public PUBLIC)
  else()
    set(type INTERFACE)
    set(public INTERFACE)
  endif()

  add_library(${target} ${type} ${ARGN})
  set(alias ${PROJECT_NAME}::lib${name})
  add_library(${alias} ALIAS ${target})
  set_target_properties(${target} PROPERTIES
    EXPORT_NAME lib${name}
  )

  cupcake_set_project_property(
    APPEND PROPERTY PROJECT_LIBRARIES "${alias}"
  )

  cupcake_generate_version_header(${name})
  # Each library has one public header directory under include/.
  target_include_directories(${target} ${public}
    "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
    "$<BUILD_INTERFACE:${CMAKE_INCLUDE_OUTPUT_DIRECTORY}>"
  )

  get_target_property(type ${target} TYPE)
  if(NOT type STREQUAL INTERFACE_LIBRARY)
    # Let the library include "private" headers if it wants.
    target_include_directories(${target}
      PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/src/lib${name}"
    )

    file(GLOB_RECURSE sources CONFIGURE_DEPENDS
      "${CMAKE_CURRENT_SOURCE_DIR}/src/lib${name}/*.cpp"
      "${CMAKE_CURRENT_SOURCE_DIR}/src/lib${name}.cpp"
    )
    target_sources(${target} PRIVATE ${sources})
    set_target_properties(${target} PROPERTIES
      OUTPUT_NAME ${name}
    )

    # In order to include the generated header by a path starting with
    # a directory matching the library name like all other library headers, we
    # must pass the `EXPORT_FILE_NAME` option.
    generate_export_header(${target}
      BASE_NAME ${name}
      EXPORT_FILE_NAME "${CMAKE_INCLUDE_OUTPUT_DIRECTORY}/${name}/export.hpp"
    )
    if(NOT type STREQUAL SHARED_LIBRARY)
      # Disable the export definitions.
      string(TOUPPER ${name} UPPER_NAME)
      target_compile_definitions(${target} PUBLIC ${UPPER_NAME}_STATIC_DEFINE)
    endif()
  endif()
  if(type STREQUAL SHARED_LIBRARY)
    set_target_properties(${target} PROPERTIES
      VERSION ${PROJECT_VERSION}
      SOVERSION ${PROJECT_VERSION_MAJOR}
    )
  endif()

  install(
    TARGETS ${target}
    EXPORT ${PROJECT_EXPORT_SET}
    ARCHIVE
      DESTINATION "${CMAKE_INSTALL_LIBDIR}"
      COMPONENT ${PROJECT_NAME}_development
    LIBRARY
      DESTINATION "${CMAKE_INSTALL_LIBDIR}"
      COMPONENT ${PROJECT_NAME}_runtime
      NAMELINK_SKIP
    RUNTIME
      DESTINATION "${CMAKE_INSTALL_BINDIR}"
      COMPONENT ${PROJECT_NAME}_runtime
    INCLUDES
      DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
  )
  # added in CMake 3.12: NAMELINK_COMPONENT
  install(
    TARGETS ${target}
    LIBRARY
      DESTINATION "${CMAKE_INSTALL_LIBDIR}"
      COMPONENT ${PROJECT_NAME}_development
      NAMELINK_ONLY
  )
  # We must install the headers with install(DIRECTORY) because
  # installing a target does not install its include directories.
  install(
    DIRECTORY
      "${CMAKE_INCLUDE_OUTPUT_DIRECTORY}/${name}"
      "${CMAKE_CURRENT_SOURCE_DIR}/include/${name}"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    COMPONENT ${PROJECT_NAME}_development
  )
endfunction()

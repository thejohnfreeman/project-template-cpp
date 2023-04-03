set(package ${CMAKE_FIND_PACKAGE_NAME})
if(${package}_FOUND)
  message(STATUS "Package '${package}' found previously.")
  return()
endif()

# Set forwarding arguments.
if(${package}_FIND_VERSION_EXACT)
  set(_EXACT EXACT)
else()
  unset(_EXACT)
endif()
if(${package}_FIND_QUIETLY)
  set(_QUIET QUIET)
else()
  unset(_QUIET)
endif()

# Forwarding call to look for configuration file.
find_package(${package}
  ${PACKAGE_FIND_VERSION}
  ${_EXACT}
  QUIET
  NO_MODULE
)

if(${package}_FOUND)
  message(STATUS "Package '${package}' found by configuration file.")
  return()
endif()

find_path(${package}_INCLUDE_DIR
  NAMES zero
)
find_library(${package}_LIBRARY
  NAMES zero
)
find_program(${package}_EXECUTABLE
  NAMES true
)

# message(STATUS "${package}_INCLUDE_DIR = ${${package}_INCLUDE_DIR}")
# message(STATUS "${package}_LIBRARY = ${${package}_LIBRARY}")
# message(STATUS "${package}_EXECUTABLE = ${${package}_EXECUTABLE}")

# TODO: Write module to read version string from installed header.

if(
  ${package}_INCLUDE_DIR AND
  ${package}_LIBRARY AND
  ${package}_EXECUTABLE
)
  if(NOT TARGET zero::libzero)
    add_library(zero::libzero UNKNOWN IMPORTED)
    set_target_properties(zero::libzero PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${${package}_INCLUDE_DIR}"
      IMPORTED_LOCATION "${${package}_LIBRARY}"
      IMPORTED_LOCATION_DEBUG "${${package}_LIBRARY}"
      IMPORTED_LOCATION_RELEASE "${${package}_LIBRARY}"
    )

    add_executable(zero::true IMPORTED)
    set_target_properties(zero::true PROPERTIES
      IMPORTED_LOCATION "${${package}_EXECUTABLE}"
      IMPORTED_LOCATION_DEBUG "${${package}_EXECUTABLE}"
      IMPORTED_LOCATION_RELEASE "${${package}_EXECUTABLE}"
    )
  endif()

  set(${package}_FOUND TRUE)
  message(STATUS "Package '${package}' found installed.")
  return()
endif()

message(WARNING "Package '${package}' not installed.")

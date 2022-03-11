if(${CMAKE_FIND_PACKAGE_NAME}_FOUND)
  message(STATUS "Package '${CMAKE_FIND_PACKAGE_NAME}' found previously.")
  return()
endif()

# Set forwarding arguments.
if(${CMAKE_FIND_PACKAGE_NAME}_FIND_VERSION_EXACT)
  set(_EXACT EXACT)
else()
  unset(_EXACT)
endif()
if(${CMAKE_FIND_PACKAGE_NAME}_FIND_QUIETLY)
  set(_QUIET QUIET)
else()
  unset(_QUIET)
endif()

# Forwarding call to look for configuration file.
find_package(${CMAKE_FIND_PACKAGE_NAME}
  ${PACKAGE_FIND_VERSION}
  ${_EXACT}
  QUIET
  NO_MODULE
)

if(${CMAKE_FIND_PACKAGE_NAME}_FOUND)
  message(STATUS "Package '${CMAKE_FIND_PACKAGE_NAME}' found by configuration file.")
  return()
endif()

find_path(${CMAKE_FIND_PACKAGE_NAME}_INCLUDE_DIR
  NAMES zero
)
find_library(${CMAKE_FIND_PACKAGE_NAME}_LIBRARY
  NAMES zero
)
find_program(${CMAKE_FIND_PACKAGE_NAME}_EXECUTABLE
  NAMES true
)

# message(STATUS "${CMAKE_FIND_PACKAGE_NAME}_INCLUDE_DIR = ${${CMAKE_FIND_PACKAGE_NAME}_INCLUDE_DIR}")
# message(STATUS "${CMAKE_FIND_PACKAGE_NAME}_LIBRARY = ${${CMAKE_FIND_PACKAGE_NAME}_LIBRARY}")
# message(STATUS "${CMAKE_FIND_PACKAGE_NAME}_EXECUTABLE = ${${CMAKE_FIND_PACKAGE_NAME}_EXECUTABLE}")

# TODO: Write module to read version string from installed header.

if(
  ${CMAKE_FIND_PACKAGE_NAME}_INCLUDE_DIR AND
  ${CMAKE_FIND_PACKAGE_NAME}_LIBRARY AND
  ${CMAKE_FIND_PACKAGE_NAME}_EXECUTABLE
)
  if(NOT TARGET zero::zero)
    add_library(zero::headers INTERFACE IMPORTED)
    set_target_properties(zero::headers PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${${CMAKE_FIND_PACKAGE_NAME}_INCLUDE_DIR}"
    )

    add_library(zero::zero UNKNOWN IMPORTED)
    set_target_properties(zero::zero PROPERTIES
      IMPORTED_LOCATION "${${CMAKE_FIND_PACKAGE_NAME}_LIBRARY}"
      IMPORTED_LOCATION_DEBUG "${${CMAKE_FIND_PACKAGE_NAME}_LIBRARY}"
      IMPORTED_LOCATION_RELEASE "${${CMAKE_FIND_PACKAGE_NAME}_LIBRARY}"
    )
    target_link_libraries(zero::zero INTERFACE zero::headers)
    add_library(zero::library ALIAS zero::zero)

    add_executable(zero::true IMPORTED)
    set_target_properties(zero::true PROPERTIES
      IMPORTED_LOCATION "${${CMAKE_FIND_PACKAGE_NAME}_EXECUTABLE}"
      IMPORTED_LOCATION_DEBUG "${${CMAKE_FIND_PACKAGE_NAME}_EXECUTABLE}"
      IMPORTED_LOCATION_RELEASE "${${CMAKE_FIND_PACKAGE_NAME}_EXECUTABLE}"
    )
    add_executable(zero::executable ALIAS zero::true)
  endif()

  set(${CMAKE_FIND_PACKAGE_NAME}_FOUND TRUE)
  message(STATUS "Package '${CMAKE_FIND_PACKAGE_NAME}' found installed.")
  return()
endif()

include(FetchContent)
FetchContent_Declare(
  ${CMAKE_FIND_PACKAGE_NAME}
  URL "${CMAKE_CURRENT_LIST_DIR}/../../00-upstream"
)
# We cannot use FetchContent_MakeAvailable because we need to modify the
# add_subdirectory command.
# TODO: Add a cupcake_FetchContent_MakeAvailable command?
FetchContent_GetProperties(${CMAKE_FIND_PACKAGE_NAME})
if(NOT ${CMAKE_FIND_PACKAGE_NAME}_POPULATED)
  FetchContent_Populate(${CMAKE_FIND_PACKAGE_NAME})
  cupcake_add_subproject(${CMAKE_FIND_PACKAGE_NAME}
    "${${CMAKE_FIND_PACKAGE_NAME}_SOURCE_DIR}"
    "${${CMAKE_FIND_PACKAGE_NAME}_BINARY_DIR}"
  )
  set(${CMAKE_FIND_PACKAGE_NAME}_FOUND TRUE)
endif()
message(STATUS "Package '${CMAKE_FIND_PACKAGE_NAME}' downloaded.")

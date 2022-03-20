set(cfpn ${CMAKE_FIND_PACKAGE_NAME})
if(${cfpn}_FOUND)
  message(STATUS "Package '${cfpn}' found previously.")
  return()
endif()

include(ExternalProject)
include(GNUInstallDirs)

# This function should only be called from a Find Module.
function(cupcake_add_external_library name)
  set(cfpn ${CMAKE_FIND_PACKAGE_NAME})
  set(fqln ${cfpn}::${name})

  if(BUILD_SHARED_LIBS)
    set(linkage SHARED)
  else()
    set(linkage STATIC)
  endif()

  set(binary_name
    ${CMAKE_${linkage}_LIBRARY_PREFIX}${name}${CMAKE_${linkage}_LIBRARY_SUFFIX}
  )

  add_library(${fqln} ${linkage} IMPORTED GLOBAL)
  if(NOT TARGET ${cfpn}::library)
    add_library(${cfpn}::library ALIAS ${fqln})
  endif()
  add_dependencies(${fqln} ${cfpn})

  set(build_types "${CMAKE_BUILD_TYPE};${CMAKE_CONFIGURATION_TYPES}")
  foreach(build_type ${build_types})
    string(REPLACE $<CONFIG> ${build_type} prefix "${CMAKE_OUTPUT_PREFIX}")
    set(include_dir "${prefix}/${CMAKE_INSTALL_INCLUDEDIR}")
    # The include directory must exist before we can set the property.
    file(MAKE_DIRECTORY "${include_dir}")
    target_include_directories(${fqln} INTERFACE "${include_dir}")
    string(TOUPPER ${build_type} BUILD_TYPE)
    set(library_binary_path
      "${prefix}/${CMAKE_INSTALL_LIBDIR}/${binary_name}"
    )
    set_target_properties(zero::zero PROPERTIES
      IMPORTED_LOCATION_${BUILD_TYPE} "${library_binary_path}"
    )
    list(APPEND byproducts "${library_binary_path}")
    set(byproducts "${byproducts}" PARENT_SCOPE)
  endforeach()
endfunction()

cupcake_add_external_library(zero)

file(TO_CMAKE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../00-upstream" url)

ExternalProject_Add(${cfpn}
  PREFIX "${CMAKE_SOURCE_DIR}/.cache"
  # The install directory is created immediately, before generator expressions
  # are evaluated. If the path has a generator expression, then on Unix it
  # just creates a directory that won't be used, but on Windows the path
  # contains illegal characters.
  URL "${url}"
  CMAKE_ARGS
    -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS}
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    "-DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}"
    "-DCMAKE_INSTALL_PREFIX=${CMAKE_OUTPUT_PREFIX}"
    "-DCMAKE_MODULE_PATH=${CMAKE_BINARY_DIR}"
  BUILD_BYPRODUCTS
  # Generator expressions are not supported in BYPRODUCTS until CMake 3.20.
  # ${CMAKE_OUTPUT_PREFIX}/${CMAKE_INSTALL_LIBDIR}/libzero.a
  "${byproducts}"
)

set(${cfpn}_FOUND TRUE)

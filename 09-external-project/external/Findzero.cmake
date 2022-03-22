set(package ${CMAKE_FIND_PACKAGE_NAME})
if(${package}_FOUND)
  message(STATUS "Package '${package}' found previously.")
  return()
endif()

include(ExternalProject)
include(GNUInstallDirs)

# When linking a dependency via ExternalProject, the author must know
# exactly what artifacts are produced, where they are installed, and under
# what names, for all platforms and configurations they are interested in
# supporting.
# Even if the dependency installs a targets file or pkg-config file or other
# package description file, that file will not be available until build time,
# but the targets are needed at configuration time.
# Even the basic facilities of Find Modules (find_path, find_library,
# find_program) are unavailable because the artifacts have not yet been built
# or installed.

# This function should only be called from a Find Module,
# for a library that follows cupcake conventions.
function(cupcake_add_external_library name version linkage)
  set(package ${CMAKE_FIND_PACKAGE_NAME})
  set(target ${package}::lib${name})

  string(REPLACE "." ";" parts ${version})
  list(GET parts 0 version_major)
  list(GET parts 1 version_minor)
  list(GET parts 2 version_patch)

  set(binary_stem
    ${CMAKE_${linkage}_LIBRARY_PREFIX}${name}
  )

  # CMake will not install a chain of symbolic links.

  add_library(${target} ${linkage} IMPORTED GLOBAL)
  if(NOT TARGET ${package}::library)
    add_library(${package}::library ALIAS ${target})
  endif()
  add_dependencies(${target} ${package})
  if(NOT WIN32 AND linkage STREQUAL "SHARED")
    set_target_properties(${target} PROPERTIES
      IMPORTED_SONAME ${binary_stem}${CMAKE_SHARED_LIBRARY_SUFFIX}.${version_major}
    )
  endif()

  set(build_types "${CMAKE_BUILD_TYPE};${CMAKE_CONFIGURATION_TYPES}")
  foreach(build_type ${build_types})
    string(REPLACE $<CONFIG> ${build_type} prefix "${CMAKE_OUTPUT_PREFIX}")
    set(include_dir "${prefix}/${CMAKE_INSTALL_INCLUDEDIR}")
    # The include directory must exist before we can set the property.
    file(MAKE_DIRECTORY "${include_dir}")
    target_include_directories(${target} INTERFACE "${include_dir}")

    set(binary_prefix "${prefix}/${CMAKE_INSTALL_LIBDIR}/${binary_stem}")
    string(TOUPPER ${build_type} BUILD_TYPE)

    set(binary_path "${binary_prefix}${CMAKE_${linkage}_LIBRARY_SUFFIX}")
    if(NOT WIN32)
      set(binary_path "${binary_path}.${version}")
    endif()
    set_target_properties(${target} PROPERTIES
      IMPORTED_LOCATION_${BUILD_TYPE} "${binary_path}"
    )
    list(APPEND byproducts "${binary_path}")

    if(WIN32 AND linkage STREQUAL "SHARED")
      set(implib_path "${binary_prefix}${CMAKE_IMPORT_LIBRARY_SUFFIX}")
      set_target_properties(${target} PROPERTIES
        IMPORTED_IMPLIB_${BUILD_TYPE} "${implib_path}"
      )
      list(APPEND byproducts "${implib_path}")
    endif()
  endforeach()
  set(byproducts "${byproducts}" PARENT_SCOPE)

  # We need to install runtime components ourselves.
  # If we just copy the artifacts, then they must be relocatable.
  # If they are not, then we must tell the external project to install them
  # directly into our install prefix at build time, but that will annoy users
  # who just want to build our project instead of installing it.
  if(linkage STREQUAL SHARED)
    install(
      FILES $<TARGET_FILE:${target}> $<$<NOT:$<BOOL:${WIN32}>>:$<TARGET_SONAME_FILE:${target}>>
      DESTINATION $<IF:$<BOOL:${WIN32}>,${CMAKE_INSTALL_BINDIR},${CMAKE_INSTALL_LIBDIR}>
    )
  endif()
  # install(IMPORTED_RUNTIME_ARTIFACTS) is not available until CMake 3.21,
  # and does not handle symbolic links.
  # install(
  #   IMPORTED_RUNTIME_ARTIFACTS ${target}
  #   LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
  #   RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
  # )
endfunction()

if(BUILD_SHARED_LIBS)
  set(linkage SHARED)
else()
  set(linkage STATIC)
endif()

cupcake_add_external_library(zero 0.1.0 ${linkage})

file(TO_CMAKE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../00-upstream" url)
ExternalProject_Add(${package}
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

set(${package}_FOUND TRUE)

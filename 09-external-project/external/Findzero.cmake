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
  if(NOT WINDOWS AND linkage STREQUAL "SHARED")
    # - Linux: libname.so.0
    # - OSX: libname.0.dylib
    set(soname "${binary_stem}")
    if(OSX)
      string(APPEND soname ".${version_major}")
    endif()
    string(APPEND soname "${CMAKE_SHARED_LIBRARY_SUFFIX}")
    if(LINUX)
      string(APPEND soname ".${version_major}")
    endif()
    set_target_properties(${target} PROPERTIES IMPORTED_SONAME "${soname}")
  endif()

  set(build_types "${CMAKE_BUILD_TYPE};${CMAKE_CONFIGURATION_TYPES}")
  foreach(build_type ${build_types})
    string(REPLACE $<CONFIG> ${build_type} prefix "${CMAKE_OUTPUT_PREFIX}")
    set(include_dir "${prefix}/${CMAKE_INSTALL_INCLUDEDIR}")
    # The include directory must exist before we can set the property.
    file(MAKE_DIRECTORY "${include_dir}")
    target_include_directories(${target} INTERFACE "${include_dir}")

    string(TOUPPER ${build_type} BUILD_TYPE)

    # - Linux: libname.so.0.1.0
    # - Windows: name.dll
    # - OSX: libname.0.1.0.dylib
    set(location "${prefix}/")
    if(WINDOWS AND linkage STREQUAL "SHARED")
      string(APPEND location "bin")
    else()
      string(APPEND location "lib")
    endif()
    string(APPEND location "/${binary_stem}")
    if(OSX AND linkage STREQUAL "SHARED")
      string(APPEND location ".${version}")
    endif()
    string(APPEND location "${CMAKE_${linkage}_LIBRARY_SUFFIX}")
    if(LINUX AND linkage STREQUAL "SHARED")
      string(APPEND location ".${version}")
    endif()

    set_target_properties(${target} PROPERTIES
      IMPORTED_LOCATION_${BUILD_TYPE} "${location}"
    )
    list(APPEND byproducts "${location}")

    if(WINDOWS AND linkage STREQUAL "SHARED")
      set(implib_path "${prefix}/lib/${binary_stem}${CMAKE_IMPORT_LIBRARY_SUFFIX}")
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
      FILES $<TARGET_FILE:${target}> $<$<NOT:$<BOOL:${WINDOWS}>>:$<TARGET_SONAME_FILE:${target}>>
      DESTINATION $<IF:$<BOOL:${WINDOWS}>,${CMAKE_INSTALL_BINDIR},${CMAKE_INSTALL_LIBDIR}>
    )
  endif()
  # added in CMake 3.21: install(IMPORTED_RUNTIME_ARTIFACTS)
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

# Compile a list of forwarded CMake arguments.
set(sep "|")
set(cmake_args
  -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS}
  -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
  "-DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}"
  "-DCMAKE_INSTALL_PREFIX=${CMAKE_OUTPUT_PREFIX}"
  "-DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}"
)
# Escape list separators in list variable values.
foreach(variable CMAKE_MODULE_PATH CMAKE_PREFIX_PATH)
  string(REPLACE ";" "${sep}" tmp "${${variable}}")
  list(APPEND cmake_args "-D${variable}=${tmp}")
endforeach()

file(TO_CMAKE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../00-upstream" url)
ExternalProject_Add(${package}
  PREFIX "${CMAKE_SOURCE_DIR}/.cache"
  # The install directory is created immediately, before generator expressions
  # are evaluated. If the path has a generator expression, then on Unix it
  # just creates a directory that won't be used, but on Windows the path
  # contains illegal characters.
  URL "${url}"
  LIST_SEPARATOR "${sep}"
  CMAKE_ARGS "${cmake_args}"
  # added in CMake 3.20: generator expressions in BYPRODUCTS
  BUILD_BYPRODUCTS "${byproducts}"
)

set(${package}_FOUND TRUE)

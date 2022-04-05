if(DEFINED_CUPCAKE_PROJECT)
  return()
endif()
set(DEFINED_CUPCAKE_PROJECT TRUE)

include(GNUInstallDirs)

macro(cupcake_project)
  # Define more project variables.
  set(PROJECT_EXPORT_SET ${PROJECT_NAME}_targets)

  #if(PROJECT_IS_TOP_LEVEL)
  if(PROJECT_NAME STREQUAL CMAKE_PROJECT_NAME)
    set(CMAKE_PROJECT_EXPORT_SET ${PROJECT_EXPORT_SET})
  endif()

  # Change defaults to follow recommended best practices.

  # On Windows, we need to make sure that shared libraries end up next to the
  # executables that require them.
  # Without setting these variables, multi-config generators generally place
  # targets in ${subdirectory}/${target}.dir/${config}.
  # We cannot use CMAKE_INSTALL_LIBDIR because the value of that variable may
  # differ between the top-level project linking against subproject
  # artifacts installed under the output prefix, and subprojects installing
  # themselves under the top-level project's output prefix.
  # In other words, if a subproject installs a library to
  # CMAKE_INSTALL_LIBDIR, then it may end up somewhere other than the
  # CMAKE_INSTALL_LIBDIR that the top-level project looks in.
  if(NOT CMAKE_OUTPUT_PREFIX)
    set(CMAKE_OUTPUT_PREFIX "${CMAKE_BINARY_DIR}/output/$<CONFIG>")
  endif()
  if(NOT CMAKE_RUNTIME_OUTPUT_DIRECTORY)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_OUTPUT_PREFIX}/bin")
  endif()
  if(NOT CMAKE_LIBRARY_OUTPUT_DIRECTORY)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_OUTPUT_PREFIX}/lib")
  endif()
  if(NOT CMAKE_ARCHIVE_OUTPUT_DIRECTORY)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_OUTPUT_PREFIX}/lib")
  endif()
  if(NOT CMAKE_INCLUDE_OUTPUT_DIRECTORY)
    set(CMAKE_INCLUDE_OUTPUT_DIRECTORY
      "${CMAKE_BINARY_DIR}/output/Common/include"
    )
  endif()

  set(CMAKE_CXX_VISIBILITY_PRESET hidden)
  set(CMAKE_VISIBILITY_INLINES_HIDDEN YES)
  set(CMAKE_EXPORT_COMPILE_COMMANDS YES)

  # Prefer the latest version of a package.
  set(CMAKE_FIND_PACKAGE_SORT_ORDER NATURAL)
  # Prefer Config Modules over Find Modules.
  set(CMAKE_FIND_PACKAGE_SORT_DIRECTION DEC)

  if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    set(OSX TRUE)
  endif()
  if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    set(LINUX TRUE)
  endif()
  if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    set(WINDOWS TRUE)
  endif()

  # Enable deterministic relocatable builds.
  set(CMAKE_BUILD_RPATH_USE_ORIGIN TRUE)
  # Use relative rpath for installation.
  if(OSX)
    set(origin @loader_path)
  else()
    set(origin $ORIGIN)
  endif()
  file(RELATIVE_PATH relDir
    ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_BINDIR}
    ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}
  )
  set(CMAKE_INSTALL_RPATH ${origin} ${origin}/${relDir})
endmacro()

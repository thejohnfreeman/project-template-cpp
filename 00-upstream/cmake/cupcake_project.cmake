if(DEFINED_CUPCAKE_PROJECT)
  return()
endif()
set(DEFINED_CUPCAKE_PROJECT TRUE)

include(GNUInstallDirs)

macro(cupcake_project)
  # Define more project variables.
  set(PROJECT_EXPORT_SET ${PROJECT_NAME}_targets)

  # Change defaults to follow recommended best practices.

  # On Windows, we need to make sure that shared libraries end up next to the
  # executables that require them.
  # Without setting these variables, multi-config generators generally place
  # targets in ${subdirectory}/${target}.dir/${config}.
  if(NOT CMAKE_RUNTIME_OUTPUT_DIRECTORY)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/output/$<CONFIG>/bin")
  endif()
  if(NOT CMAKE_LIBRARY_OUTPUT_DIRECTORY)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/output/$<CONFIG>/lib")
  endif()
  if(NOT CMAKE_ARCHIVE_OUTPUT_DIRECTORY)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/output/$<CONFIG>/lib")
  endif()

  set(CMAKE_CXX_VISIBILITY_PRESET hidden)
  set(CMAKE_VISIBILITY_INLINES_HIDDEN YES)
  set(CMAKE_EXPORT_COMPILE_COMMANDS YES)

  # Enable deterministic relocatable builds.
  set(CMAKE_BUILD_RPATH_USE_ORIGIN TRUE)
  # Use relative rpath for installation.
  file(RELATIVE_PATH relDir
    ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_BINDIR}
    ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}
  )
  set(CMAKE_INSTALL_RPATH $ORIGIN $ORIGIN/${relDir})
endmacro()

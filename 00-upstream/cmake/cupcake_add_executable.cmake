if(DEFINED_CUPCAKE_ADD_EXECUTABLE)
  return()
endif()
set(DEFINED_CUPCAKE_ADD_EXECUTABLE TRUE)

include(GNUInstallDirs)

# A target representing all executables declared with the function below.
add_custom_target(executables)

# add_executable(<name> [<source>...])
function(cupcake_add_executable name)
  set(target ${PROJECT_NAME}_${name})
  set(this ${target} PARENT_SCOPE)
  add_executable(${target} ${ARGN})
  set_target_properties(${target} PROPERTIES
    OUTPUT_NAME ${name}
    EXPORT_NAME ${name}
  )
  add_executable(${PROJECT_NAME}::${name} ALIAS ${target})

  # Add a convenient target for the first executable in this project.
  if(NOT TARGET ${PROJECT_NAME}::executable)
    add_executable(${PROJECT_NAME}::executable ALIAS ${target})
    # TODO: How to export this alias? We do not have INTERFACE for executable
    # like we do for library.
  endif()

  # if(PROJECT_IS_TOP_LEVEL)
  if(PROJECT_NAME STREQUAL CMAKE_PROJECT_NAME)
    add_dependencies(executables ${target})
    # Add a convenient target for the first executable in the main project.
    if(NOT TARGET executable)
      add_custom_target(executable DEPENDS ${target})
    endif()
  endif()

  install(
    TARGETS ${target}
    EXPORT ${PROJECT_EXPORT_SET}
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
  )
endfunction()

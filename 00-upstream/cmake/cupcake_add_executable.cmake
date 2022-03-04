if(DEFINED_CUPCAKE_ADD_EXECUTABLE)
  return()
endif()
set(DEFINED_CUPCAKE_ADD_EXECUTABLE TRUE)

include(GNUInstallDirs)

function(cupcake_add_executable name)
  set(target ${PROJECT_NAME}_${name})
  set(this ${target} PARENT_SCOPE)
  add_executable(${target} ${ARGN})
  set_target_properties(${target} PROPERTIES
    OUTPUT_NAME ${name}
    EXPORT_NAME ${name}
  )
  add_executable(${PROJECT_NAME}::${name} ALIAS ${target})

  # Add a convenient target for the first top-level executable.
  if(${PROJECT_NAME} STREQUAL ${CMAKE_PROJECT_NAME} AND NOT TARGET executable)
    add_custom_target(executable DEPENDS ${target})
  endif()

  install(
    TARGETS ${target}
    EXPORT ${PROJECT_EXPORT_SET}
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
  )
endfunction()

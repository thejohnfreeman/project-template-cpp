include_guard(GLOBAL)

include(GNUInstallDirs)

# A target representing all executables declared with the function below.
add_custom_target(executables)

# add_executable(<name> [<source>...])
function(cupcake_add_executable name)
  set(target ${PROJECT_NAME}_${name})
  set(this ${target} PARENT_SCOPE)
  add_executable(${target} ${ARGN})
  add_executable(${PROJECT_NAME}::${name} ALIAS ${target})

  # if(PROJECT_IS_TOP_LEVEL)
  if(PROJECT_NAME STREQUAL CMAKE_PROJECT_NAME)
    add_dependencies(executables ${target})
  endif()

  # Let the executable include "private" headers if it wants.
  target_include_directories(${target}
    PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/src/${name}"
  )

  file(GLOB_RECURSE sources CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/src/${name}/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/${name}.cpp"
  )
  target_sources(${target} PRIVATE ${sources})

  set_target_properties(${target} PROPERTIES
    OUTPUT_NAME ${name}
    EXPORT_NAME ${name}
  )

  install(
    TARGETS ${target}
    EXPORT ${PROJECT_EXPORT_SET}
    RUNTIME
      DESTINATION "${CMAKE_INSTALL_BINDIR}"
      COMPONENT ${PROJECT_NAME}_runtime
  )
endfunction()

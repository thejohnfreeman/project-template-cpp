if(DEFINED_CUPCAKE_ADD_HEADERS)
  return()
endif()
set(DEFINED_CUPCAKE_ADD_HEADERS TRUE)

include(GNUInstallDirs)

function(cupcake_add_headers)
  set(target ${PROJECT_NAME}_headers)
  add_library(${target} INTERFACE)
  set_target_properties(${target} PROPERTIES EXPORT_NAME headers)
  add_library(${PROJECT_NAME}::headers ALIAS ${target})
  target_include_directories(${target}
    INTERFACE "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>"
  )

  if(${PROJECT_NAME} STREQUAL ${CMAKE_PROJECT_NAME} AND NOT TARGET headers)
    add_custom_target(headers DEPENDS ${target})
  endif()

  install(
    TARGETS ${target}
    EXPORT ${PROJECT_EXPORT_SET}
    INCLUDES DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
  )
  # We must include a separate command to install the headers because
  # installing a target does not install its include directories.
  install(
    DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    PATTERN CMakeLists.txt EXCLUDE
  )
endfunction()

include(GNUInstallDirs)

add_library(${PROJECT_NAME}_headers INTERFACE)
set_target_properties(${PROJECT_NAME}_headers PROPERTIES EXPORT_NAME headers)
add_library(${PROJECT_NAME}::headers ALIAS ${PROJECT_NAME}_headers)
target_include_directories(${PROJECT_NAME}_headers
  INTERFACE "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>"
)

if(${PROJECT_NAME} STREQUAL ${CMAKE_PROJECT_NAME})
  add_custom_target(headers DEPENDS ${PROJECT_NAME}_headers)
endif()

install(
  TARGETS ${PROJECT_NAME}_headers
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

include(GNUInstallDirs)

add_library(${PROJECT_NAME}_headers INTERFACE)
set_target_properties(${PROJECT_NAME}_headers PROPERTIES EXPORT_NAME headers)
add_library(${PROJECT_NAME}::headers ALIAS ${PROJECT_NAME}_headers)
target_include_directories(${PROJECT_NAME}_headers
  INTERFACE
  "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>"
  "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>"
)
install(TARGETS ${PROJECT_NAME}_headers EXPORT ${PROJECT_EXPORT_SET})
# We must include a separate command to install the headers because
# installing a target does not install its include directories.
install(
  DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/"
  DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
  PATTERN CMakeLists.txt EXCLUDE
)

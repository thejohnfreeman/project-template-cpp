include(GNUInstallDirs)

add_library(headers INTERFACE)
add_library(${PROJECT_NAME}::headers ALIAS headers)
target_include_directories(headers
  INTERFACE
  "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>"
  "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>"
)
install(TARGETS headers EXPORT ${PROJECT_EXPORT_SET})
# We must include a separate command to install the headers because
# installing a target does not install its include directories.
install(
  DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/"
  DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
  PATTERN CMakeLists.txt EXCLUDE
)

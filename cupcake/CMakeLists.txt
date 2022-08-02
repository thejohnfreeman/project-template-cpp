cmake_minimum_required(VERSION 3.11)

project(cupcake VERSION 0.1.0 LANGUAGES NONE)

include(CMakePackageConfigHelpers)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
include(cupcake)

# if(NOT PROJECT_IS_TOP_LEVEL)
if(NOT PROJECT_NAME STREQUAL CMAKE_PROJECT_NAME)
  return()
endif()

cupcake_project()

install(
  DIRECTORY cmake/
  DESTINATION "${CMAKE_INSTALL_EXPORTDIR}/${PROJECT_NAME}/"
)

configure_package_config_file(
  cupcake-config.cmake.in
  "${PROJECT_EXPORT_DIR}/${PROJECT_NAME}-config.cmake"
  INSTALL_DESTINATION "${CMAKE_INSTALL_EXPORTDIR}/${PROJECT_NAME}"
  NO_SET_AND_CHECK_MACRO
  NO_CHECK_REQUIRED_COMPONENTS_MACRO
)

set(PROJECT_COMPATIBILITY SameMajorVersion)
if(PROJECT_VERSION_MAJOR EQUAL 0)
  set(PROJECT_COMPATIBILITY SameMinorVersion)
endif()
write_basic_package_version_file(
  "${PROJECT_EXPORT_DIR}/${PROJECT_NAME}-config-version.cmake"
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY ${PROJECT_COMPATIBILITY}
)

install(
  DIRECTORY "${PROJECT_EXPORT_DIR}"
  DESTINATION "${CMAKE_INSTALL_EXPORTDIR}"
)

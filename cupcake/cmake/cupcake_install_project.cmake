if(DEFINED_CUPCAKE_INSTALL_PROJECT)
  return()
endif()
set(DEFINED_CUPCAKE_INSTALL_PROJECT TRUE)

include(cupcake_project_properties)
include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

set(CUPCAKE_PACKAGE_CONFIG_INPUT
  "${CMAKE_CURRENT_LIST_DIR}/data/package-config.cmake.in"
)

# This macro must be called last in the project's root CMakeLists.txt,
# after the PROJECT_DEPENDENCIES variable has been populated.
macro(cupcake_install_project)
  # Install in the build directory a targets file importing artifacts from
  # the build directory.
  export(EXPORT ${PROJECT_EXPORT_SET}
    FILE "${PROJECT_EXPORT_DIR}/${PROJECT_NAME}-targets.cmake"
    NAMESPACE ${PROJECT_NAME}::
  )

  # Install in the install directory a targets file importing artifacts from
  # the install directory.
  install(EXPORT ${PROJECT_EXPORT_SET}
    DESTINATION "${CMAKE_INSTALL_EXPORTDIR}/${PROJECT_NAME}"
    FILE ${PROJECT_NAME}-targets.cmake
    NAMESPACE ${PROJECT_NAME}::
  )

  cupcake_get_project_property(PROJECT_DEPENDENCIES)
  cupcake_get_project_property(PROJECT_LIBRARIES)
  configure_package_config_file("${CUPCAKE_PACKAGE_CONFIG_INPUT}"
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
    COMPONENT ${PROJECT_NAME}_development
    PATTERN ${PROJECT_NAME}-targets.cmake EXCLUDE
  )
endmacro()

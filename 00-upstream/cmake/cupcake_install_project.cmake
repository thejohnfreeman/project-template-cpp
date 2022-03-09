if(DEFINED_CUPCAKE_INSTALL_PROJECT)
  return()
endif()
set(DEFINED_CUPCAKE_INSTALL_PROJECT TRUE)

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

set(package_config_input "${CMAKE_CURRENT_LIST_DIR}/package-config.cmake.in")

macro(cupcake_install_project)
  set(CMAKE_INSTALL_EXPORTDIR "${CMAKE_INSTALL_LIBDIR}/cmake")
  if(WIN32)
    set(CMAKE_INSTALL_EXPORTDIR .)
  endif()

  set(CMAKE_CURRENT_EXPORT_DIR "${CMAKE_CURRENT_BINARY_DIR}/export/${PROJECT_NAME}")

  # Install in the build directory a targets file importing artifacts from
  # the build directory.
  export(EXPORT ${PROJECT_EXPORT_SET}
    FILE "${CMAKE_CURRENT_EXPORT_DIR}/${PROJECT_NAME}-targets.cmake"
    NAMESPACE ${PROJECT_NAME}::
  )

  # Install in the install directory a targets file importing artifacts from
  # the install directory.
  install(EXPORT ${PROJECT_EXPORT_SET}
    DESTINATION "${CMAKE_INSTALL_EXPORTDIR}/${PROJECT_NAME}"
    FILE ${PROJECT_NAME}-targets.cmake
    NAMESPACE ${PROJECT_NAME}::
  )

  get_property(CUPCAKE_PROJECT_DEPENDENCIES
    GLOBAL PROPERTY CUPCAKE_PROJECT_DEPENDENCIES)
  configure_package_config_file("${package_config_input}"
    "${CMAKE_CURRENT_EXPORT_DIR}/${PROJECT_NAME}-config.cmake"
    INSTALL_DESTINATION "${CMAKE_INSTALL_EXPORTDIR}/${PROJECT_NAME}"
    NO_SET_AND_CHECK_MACRO
    NO_CHECK_REQUIRED_COMPONENTS_MACRO
  )

  set(PROJECT_COMPATIBILITY SameMajorVersion)
  if(${PROJECT_VERSION_MAJOR} EQUAL 0)
    set(PROJECT_COMPATIBILITY SameMinorVersion)
  endif()
  write_basic_package_version_file(
    "${CMAKE_CURRENT_EXPORT_DIR}/${PROJECT_NAME}-config-version.cmake"
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY ${PROJECT_COMPATIBILITY}
  )

  install(
    DIRECTORY "${CMAKE_CURRENT_EXPORT_DIR}"
    DESTINATION "${CMAKE_INSTALL_EXPORTDIR}"
    PATTERN ${PROJECT_NAME}-targets.cmake EXCLUDE
  )
endmacro()

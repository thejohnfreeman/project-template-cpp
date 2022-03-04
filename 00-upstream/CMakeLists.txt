cmake_minimum_required(VERSION 3.7)

project(greetings
  VERSION 0.1.0
  DESCRIPTION "An example library and executable, with tests."
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")

include(cupcake_project)

cupcake_project()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_FIND_PACKAGE_SORT_ORDER NATURAL)
set(CMAKE_FIND_PACKAGE_SORT_DIRECTION DEC)
# dependencies {
# }

find_package(doctest REQUIRED)

add_subdirectory(include)
add_subdirectory(src)
enable_testing()
add_subdirectory(tests)

include(GNUInstallDirs)
set(CMAKE_INSTALL_EXPORTDIR "${CMAKE_INSTALL_LIBDIR}/cmake")
if(WIN32)
  set(CMAKE_INSTALL_EXPORTDIR .)
endif()

set(CMAKE_CURRENT_EXPORT_DIR "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}")

export(EXPORT ${PROJECT_EXPORT_SET}
  FILE "${CMAKE_CURRENT_EXPORT_DIR}/${PROJECT_NAME}-targets.cmake"
  NAMESPACE ${PROJECT_NAME}::
)

include(CMakePackageConfigHelpers)

configure_package_config_file("${CMAKE_CURRENT_SOURCE_DIR}/cmake/package-config.cmake.in"
  "${CMAKE_CURRENT_EXPORT_DIR}/${PROJECT_NAME}-config.cmake"
  INSTALL_DESTINATION "${CMAKE_INSTALL_EXPORTDIR}/${PROJECT_NAME}}"
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
)

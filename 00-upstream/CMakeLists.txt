cmake_minimum_required(VERSION 3.7)

project(greetings
  VERSION 0.1.0
  DESCRIPTION "An example library and executable, with tests."
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)

include(GNUInstallDirs)

# Need to make sure executables end up next to shared libraries on Windows.
if(NOT CMAKE_RUNTIME_OUTPUT_DIRECTORY)
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/$<CONFIG>/bin")
endif()
if(NOT CMAKE_LIBRARY_OUTPUT_DIRECTORY)
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/$<CONFIG>/lib")
endif()
if(NOT CMAKE_ARCHIVE_OUTPUT_DIRECTORY)
  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/$<CONFIG>/lib")
endif()

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN YES)

# Enable deterministic relocatable builds.
set(CMAKE_BUILD_RPATH_USE_ORIGIN TRUE)
# Use relative rpath for installation.
file(RELATIVE_PATH relDir
  ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_BINDIR}
  ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR}
)
set(CMAKE_INSTALL_RPATH $ORIGIN $ORIGIN/${relDir})

set(CMAKE_FIND_PACKAGE_SORT_ORDER NATURAL)
set(CMAKE_FIND_PACKAGE_SORT_DIRECTION DEC)
# dependencies {
# }

find_package(doctest REQUIRED)

set(PROJECT_EXPORT_SET ${PROJECT_NAME}_targets)

add_subdirectory(include)
add_subdirectory(src)
enable_testing()
add_subdirectory(tests)

set(PROJECT_SLUG ${PROJECT_NAME}-${PROJECT_VERSION_MAJOR})
set(CMAKE_CURRENT_EXPORT_DIR "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_SLUG}")
set(CMAKE_INSTALL_EXPORTDIR "${CMAKE_INSTALL_LIBDIR}/cmake")
if(WIN32)
  set(CMAKE_INSTALL_EXPORTDIR .)
endif()

export(EXPORT ${PROJECT_EXPORT_SET}
  FILE "${CMAKE_CURRENT_EXPORT_DIR}/${PROJECT_NAME}-targets.cmake"
  NAMESPACE ${PROJECT_NAME}::
)

include(CMakePackageConfigHelpers)

configure_package_config_file("${CMAKE_CURRENT_SOURCE_DIR}/cmake/package-config.cmake.in"
  "${CMAKE_CURRENT_EXPORT_DIR}/${PROJECT_NAME}-config.cmake"
  INSTALL_DESTINATION "${CMAKE_INSTALL_EXPORTDIR}/${PROJECT_SLUG}"
  NO_SET_AND_CHECK_MACRO
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

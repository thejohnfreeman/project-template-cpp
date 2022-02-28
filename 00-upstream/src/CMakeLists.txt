include(GenerateExportHeader)
include(GNUInstallDirs)

add_library(library)
add_library(${PROJECT_NAME}::library ALIAS library)
target_sources(library PRIVATE greetings.cpp)
# Let the library include "private" headers if it wants.
target_include_directories(library PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}")
target_link_libraries(library PUBLIC ${PROJECT_NAME}::headers)

# In order to include the generated header by a path starting with a directory
# matching the package name like all other package headers, we must pass the
# `EXPORT_FILE_NAME` option.
generate_export_header(library
  BASE_NAME ${PROJECT_NAME}
  EXPORT_FILE_NAME "${CMAKE_CURRENT_BINARY_DIR}/include/${PROJECT_NAME}/export.hpp"
)
target_include_directories(library
  PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include>"
)
install(
  DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/include/"
  DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

get_target_property(library_type library TYPE)
if(NOT library_type STREQUAL SHARED_LIBRARY)
  # Disable the export definitions for non-shared libraries.
  string(TOUPPER ${PROJECT_NAME} UPPER_PROJECT_NAME)
  target_compile_definitions(library PUBLIC ${UPPER_PROJECT_NAME}_STATIC_DEFINE)
endif()

install(
  TARGETS library
  EXPORT ${PROJECT_EXPORT_SET}
  ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
  LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
  RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
)

add_executable(executable)
target_sources(executable PRIVATE greet.cpp)
add_executable(${PROJECT_NAME}::executable ALIAS executable)
target_link_libraries(executable PRIVATE ${PROJECT_NAME}::library)
install(
  TARGETS executable
  EXPORT ${PROJECT_EXPORT_SET}
  RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
)

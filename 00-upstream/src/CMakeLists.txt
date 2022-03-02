include(GenerateExportHeader)
include(GNUInstallDirs)

add_library(${PROJECT_NAME}_library)
set_target_properties(${PROJECT_NAME}_library PROPERTIES EXPORT_NAME library)
add_library(${PROJECT_NAME}::library ALIAS ${PROJECT_NAME}_library)
target_sources(${PROJECT_NAME}_library PRIVATE greetings.cpp)
# Let the library include "private" headers if it wants.
target_include_directories(${PROJECT_NAME}_library
  PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}"
)
target_link_libraries(${PROJECT_NAME}_library PUBLIC ${PROJECT_NAME}::headers)

# In order to include the generated header by a path starting with a directory
# matching the package name like all other package headers, we must pass the
# `EXPORT_FILE_NAME` option.
generate_export_header(${PROJECT_NAME}_library
  BASE_NAME ${PROJECT_NAME}
  EXPORT_FILE_NAME "${CMAKE_CURRENT_BINARY_DIR}/include/${PROJECT_NAME}/export.hpp"
)
target_include_directories(${PROJECT_NAME}_library
  PUBLIC "$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include>"
)
install(
  DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/include/"
  DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

get_target_property(library_type ${PROJECT_NAME}_library TYPE)
if(NOT library_type STREQUAL SHARED_LIBRARY)
  # Disable the export definitions for non-shared libraries.
  string(TOUPPER ${PROJECT_NAME} UPPER_PROJECT_NAME)
  target_compile_definitions(${PROJECT_NAME}_library
    PUBLIC ${UPPER_PROJECT_NAME}_STATIC_DEFINE
  )
endif()

install(
  TARGETS ${PROJECT_NAME}_library
  EXPORT ${PROJECT_EXPORT_SET}
  ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
  LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
  RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
)

add_executable(${PROJECT_NAME}_executable)
set_target_properties(${PROJECT_NAME}_executable PROPERTIES
  OUTPUT_NAME executable
  EXPORT_NAME executable
)
target_sources(${PROJECT_NAME}_executable PRIVATE greet.cpp)
add_executable(${PROJECT_NAME}::executable ALIAS ${PROJECT_NAME}_executable)
target_link_libraries(${PROJECT_NAME}_executable
  PRIVATE ${PROJECT_NAME}::library
)
install(
  TARGETS ${PROJECT_NAME}_executable
  EXPORT ${PROJECT_EXPORT_SET}
  RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
)

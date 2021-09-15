include(FutureInstallDirs)
include(GenerateExportHeader)

add_library(headers INTERFACE)
add_library(${PROJECT_NAME}::headers ALIAS headers)
target_include_directories(headers
  INTERFACE
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)
install(TARGETS headers EXPORT ${PROJECT_EXPORT_SET})
install(
  DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
  FILES_MATCHING PATTERN "*.h" PATTERN "*.hpp"
)

# We can only call `generate_export_header` on a shared library,
# forcing us to declare one here.
add_library(dummy SHARED IMPORTED)
# Isolate the generated header to a subdirectory.
generate_export_header(dummy
  BASE_NAME shared
  EXPORT_FILE_NAME include/shared_export.h
)
# We must add the generated header to the include path
# for an out-of-source build.
target_include_directories(headers
  INTERFACE "$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include>"
)

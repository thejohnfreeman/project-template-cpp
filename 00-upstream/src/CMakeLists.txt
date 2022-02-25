include(GNUInstallDirs)

add_library(library)
add_library(${PROJECT_NAME}::library ALIAS library)
target_sources(library PRIVATE greetings.cpp)
# Let the library include "private" headers if it wants.
target_include_directories(library PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(library PUBLIC ${PROJECT_NAME}::headers)

install(
  TARGETS library
  EXPORT ${PROJECT_EXPORT_SET}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

add_executable(executable)
target_sources(executable PRIVATE greet.cpp)
add_executable(${PROJECT_NAME}::executable ALIAS executable)
target_link_libraries(executable PRIVATE ${PROJECT_NAME}::library)
install(
  TARGETS executable
  EXPORT ${PROJECT_EXPORT_SET}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

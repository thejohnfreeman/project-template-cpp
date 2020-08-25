include(GNUInstallDirs)

# By convention, name the main target after the project.
add_library(${PROJECT_NAME} greetings.cpp)
add_library(${PROJECT_NAME}::${PROJECT_NAME} ALIAS ${PROJECT_NAME})
install(
  TARGETS ${PROJECT_NAME}
  EXPORT ${PROJECT_EXPORT_SET}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
target_link_libraries(${PROJECT_NAME} PUBLIC ${PROJECT_NAME}::headers)
# Let the library include "private" headers if it wants.
target_include_directories(${PROJECT_NAME}
  PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}
)

add_executable(greet greet.cpp)
target_link_libraries(greet PRIVATE ${PROJECT_NAME}::${PROJECT_NAME})
install(
  TARGETS greet
  EXPORT ${DEFAULT_EXPORT_SET}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

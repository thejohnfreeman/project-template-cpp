# By convention, name the library target after the project.
future_add_library(${PROJECT_NAME} greetings.cpp)
target_link_libraries(${PROJECT_NAME} PUBLIC ${PROJECT_NAME}::headers)
# Let the library include "private" headers if it wants.
target_include_directories(${PROJECT_NAME}
  PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}
)

add_executable(greet greet.cpp)
target_link_libraries(greet PRIVATE ${PROJECT_NAME}::${PROJECT_NAME})
future_install(
  TARGETS greet
  EXPORT ${FUTURE_DEFAULT_EXPORT_SET}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

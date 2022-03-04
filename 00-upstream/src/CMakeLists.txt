include(cupcake_add_library)

cupcake_add_library(library)
target_sources(${this} PRIVATE greetings.cpp)

add_executable(${PROJECT_NAME}_executable)
set_target_properties(${PROJECT_NAME}_executable PROPERTIES
  OUTPUT_NAME executable
  EXPORT_NAME executable
)
target_sources(${PROJECT_NAME}_executable PRIVATE greet.cpp)
add_executable(${PROJECT_NAME}::executable ALIAS ${PROJECT_NAME}_executable)

if(${PROJECT_NAME} STREQUAL ${CMAKE_PROJECT_NAME})
  add_custom_target(executable DEPENDS ${PROJECT_NAME}_executable)
endif()

install(
  TARGETS ${PROJECT_NAME}_executable
  EXPORT ${PROJECT_EXPORT_SET}
  RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
)

target_link_libraries(${PROJECT_NAME}_executable
  PRIVATE ${PROJECT_NAME}::library
)

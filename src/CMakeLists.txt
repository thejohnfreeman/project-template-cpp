# By convention, name the library target after the project.
future_add_library(${PROJECT_NAME} greetings.cpp)
target_link_libraries(${PROJECT_NAME} PUBLIC ${PROJECT_NAME}::headers)
# Let the library include "private" headers if it wants.
target_include_directories(${PROJECT_NAME}
  PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}
)

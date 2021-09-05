include(FutureInstallDirs)

add_library(static STATIC)
add_library(${PROJECT_NAME}::static ALIAS static)
target_sources(static PRIVATE greetings.cpp)
# Let the library include "private" headers if it wants.
target_include_directories(static PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(static PUBLIC ${PROJECT_NAME}::headers)

add_library(shared SHARED)
add_library(${PROJECT_NAME}::shared ALIAS shared)
target_sources(shared PRIVATE greetings.cpp)
target_include_directories(shared PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(shared PUBLIC ${PROJECT_NAME}::headers)

if(BUILD_SHARED_LIBS)
  set(DEFAULT_LINKAGE shared)
else()
  set(DEFAULT_LINKAGE static)
endif()
add_library(${PROJECT_NAME}::library ALIAS ${DEFAULT_LINKAGE})

install(
  TARGETS static shared
  EXPORT ${PROJECT_EXPORT_SET}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

add_executable(executable greet.cpp)
add_executable(${PROJECT_NAME}::executable ALIAS executable)
target_link_libraries(executable PRIVATE ${PROJECT_NAME}::library)
install(
  TARGETS executable
  EXPORT ${PROJECT_EXPORT_SET}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

include(FetchContent)
FetchContent_Declare(
  two
  URL "${CMAKE_CURRENT_LIST_DIR}/../../02-add-subdirectory"
)
FetchContent_GetProperties(two)
if(NOT two_POPULATED)
  FetchContent_Populate(two)
endif()
cupcake_add_subproject(two "${two_SOURCE_DIR}" "${two_BINARY_DIR}")
set(two_FOUND TRUE)

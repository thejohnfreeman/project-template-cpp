include(FetchContent)
FetchContent_Declare(
  zero
  URL "${CMAKE_CURRENT_LIST_DIR}/../../00-upstream"
)
# We cannot use FetchContent_MakeAvailable because we need to modify the
# add_subdirectory command.
# TODO: Add a cupcake_FetchContent_MakeAvailable command?
FetchContent_GetProperties(zero)
if(NOT zero_POPULATED)
  FetchContent_Populate(zero)
  cupcake_add_subproject(zero "${zero_SOURCE_DIR}" "${zero_BINARY_DIR}")
endif()

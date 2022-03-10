include(FetchContent)
FetchContent_Declare(
  one
  URL "${CMAKE_CURRENT_LIST_DIR}/../../01-find-package"
)
FetchContent_GetProperties(one)
if(NOT one_POPULATED)
  FetchContent_Populate(one)
  cupcake_add_subproject(one "${one_SOURCE_DIR}" "${one_BINARY_DIR}")
endif()

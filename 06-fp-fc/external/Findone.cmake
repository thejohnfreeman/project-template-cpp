if(${CMAKE_FIND_PACKAGE_NAME}_FOUND)
  message(STATUS "Package '${CMAKE_FIND_PACKAGE_NAME}' found previously.")
  return()
endif()

include(FetchContent)
FetchContent_Declare(
  ${CMAKE_FIND_PACKAGE_NAME}
  URL "${CMAKE_CURRENT_LIST_DIR}/../../01-find-package"
)
FetchContent_GetProperties(${CMAKE_FIND_PACKAGE_NAME})
if(NOT ${CMAKE_FIND_PACKAGE_NAME}_POPULATED)
  FetchContent_Populate(${CMAKE_FIND_PACKAGE_NAME})
  cupcake_add_subproject(${CMAKE_FIND_PACKAGE_NAME}
    "${${CMAKE_FIND_PACKAGE_NAME}_SOURCE_DIR}"
    "${${CMAKE_FIND_PACKAGE_NAME}_BINARY_DIR}"
  )
  set(${CMAKE_FIND_PACKAGE_NAME}_FOUND TRUE)
endif()

if(${CMAKE_FIND_PACKAGE_NAME}_FOUND)
  message(STATUS "Package '${CMAKE_FIND_PACKAGE_NAME}' found previously.")
  return()
endif()

cupcake_add_subproject(${CMAKE_FIND_PACKAGE_NAME} 00-upstream)
set(${CMAKE_FIND_PACKAGE_NAME}_FOUND TRUE)

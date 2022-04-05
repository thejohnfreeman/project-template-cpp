if(DEFINED_CUPCAKE_PROJECT_PROPERTIES)
  return()
endif()
set(DEFINED_CUPCAKE_PROJECT_PROPERTIES TRUE)

function(cupcake_set_project_property)
  set_property(DIRECTORY "${PROJECT_SOURCE_DIR}" ${ARGN})
endfunction()

macro(cupcake_get_project_property property)
  get_property(${property}
    DIRECTORY "${PROJECT_SOURCE_DIR}"
    PROPERTY ${property}
  )
endmacro()

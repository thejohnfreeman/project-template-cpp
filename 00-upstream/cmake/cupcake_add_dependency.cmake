if(DEFINED_CUPCAKE_ADD_DEPENDENCY)
  return()
endif()
set(DEFINED_CUPCAKE_ADD_DEPENDENCY TRUE)

function(cupcake_add_dependency name version)
  set_property(DIRECTORY "${PROJECT_SOURCE_DIR}"
    APPEND PROPERTY PROJECT_DEPENDENCIES "${name}\;${version}")
endfunction()

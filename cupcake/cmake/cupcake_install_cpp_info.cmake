if(DEFINED_CUPCAKE_INSTALL_CPP_INFO)
  return()
endif()
set(DEFINED_CUPCAKE_INSTALL_CPP_INFO TRUE)

set(CUPCAKE_MODULE_DIR "${CMAKE_CURRENT_LIST_DIR}")
file(READ "${CMAKE_CURRENT_LIST_DIR}/data/install_cpp_info.cmake"
  CUPCAKE_INSTALL_CPP_INFO
)

function(cupcake_install_cpp_info)
  install(
    CODE "
if(GENERATOR_IS_MULTI_CONFIG)
  set(config $<CONFIG>)
else()
  set(config ${CMAKE_BUILD_TYPE})
endif()
string(TOUPPER \${config} CONFIG)
set(CUPCAKE_MODULE_DIR \"${CUPCAKE_MODULE_DIR}\")
set(PACKAGE_NAME ${PROJECT_NAME})
${CUPCAKE_INSTALL_CPP_INFO}
"
    COMPONENT ${PROJECT_NAME}_development
  )
endfunction()
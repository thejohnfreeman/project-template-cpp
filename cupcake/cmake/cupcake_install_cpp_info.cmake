include_guard(GLOBAL)

include(cupcake_module_dir)

file(READ "${CUPCAKE_MODULE_DIR}/data/install_cpp_info.cmake"
  CUPCAKE_INSTALL_CPP_INFO
)

function(cupcake_install_cpp_info)
  install(
    CODE "
set(CUPCAKE_MODULE_DIR \"${CUPCAKE_MODULE_DIR}\")
set(PACKAGE_NAME ${PROJECT_NAME})
string(TOUPPER $<CONFIG> CONFIG)
${CUPCAKE_INSTALL_CPP_INFO}
"
    COMPONENT ${PROJECT_NAME}_development
  )
endfunction()

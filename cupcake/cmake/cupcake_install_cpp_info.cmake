include_guard(GLOBAL)

include(cupcake_module_dir)

file(READ "${CUPCAKE_MODULE_DIR}/data/install_cpp_info.cmake"
  CUPCAKE_INSTALL_CPP_INFO
)

# This function works in steps:
# - When the package is installed, execute the below code snippet.
# - The snippet itself copies code from the nearby `install_cpp_info.cmake`
# file. If I copy that code here directly, then I have to escape every quote.
# Leaving it in that file keeps it easier to read.
# - I cannot put the entire snippet into that file because some parameters
# must be captured when this function is called, not at install time.
# - That file configures a CMake project whose `CMakeLists.txt` is in the
# nearby directory `project_cpp_info`. That project finds the installed
# package with `find_package` and then generates and installs a `cpp_info.py`
# under `CMAKE_INSTALL_PREFIX`.
function(cupcake_install_cpp_info)
  install(
    CODE "
set(CMAKE_BINARY_DIR \"${CMAKE_BINARY_DIR}\")
set(PACKAGE_NAME ${PROJECT_NAME})
string(TOUPPER $<CONFIG> CONFIG)
set(CMAKE_PREFIX_PATH \"${CMAKE_PREFIX_PATH}\")
set(CMAKE_MODULE_PATH \"${CMAKE_MODULE_PATH}\")
set(CUPCAKE_MODULE_DIR \"${CUPCAKE_MODULE_DIR}\")
${CUPCAKE_INSTALL_CPP_INFO}
"
    COMPONENT ${PROJECT_NAME}_development
  )
endfunction()

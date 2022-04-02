# This script runs in the context of `cmake_install.cmake`.
# The parameters it takes from that context are `CMAKE_BINARY_DIR` and
# `CMAKE_INSTALL_PREFIX`.
# These other parameters must be passed from the configuration:
# - CUPCAKE_MODULE_DIR
# - PACKAGE_NAME
# - CONFIG

set(parameters
  CMAKE_INSTALL_PREFIX
  CMAKE_BINARY_DIR
  CUPCAKE_MODULE_DIR
  PACKAGE_NAME
  CONFIG
)
foreach(parameter ${parameters})
  if(NOT ${parameter})
    list(APPEND missing_parameters ${parameter})
  endif()
endforeach()
if(missing_parameters)
  message(FATAL_ERROR "missing parameters: ${missing_parameters}")
endif()

message(STATUS "CMAKE_INSTALL_PREFIX = '${CMAKE_INSTALL_PREFIX}'")
message(STATUS "CMAKE_BINARY_DIR = '${CMAKE_BINARY_DIR}'")
message(STATUS "CUPCAKE_MODULE_DIR = '${CUPCAKE_MODULE_DIR}'")
message(STATUS "PACKAGE_NAME = '${PACKAGE_NAME}'")
message(STATUS "CONFIG = '${CONFIG}'")

set(tmp_dir "${CMAKE_BINARY_DIR}/tmp")
file(MAKE_DIRECTORY "${tmp_dir}")
execute_process(
  COMMAND "${CMAKE_COMMAND}"
    "-DPACKAGE_NAME=${PACKAGE_NAME}"
    "-DCONFIG=${CONFIG}"
    "-DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}"
    "${CUPCAKE_MODULE_DIR}/project_cpp_info"
  WORKING_DIRECTORY "${tmp_dir}"
)
file(REMOVE_RECURSE "${tmp_dir}")

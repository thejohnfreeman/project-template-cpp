# This script runs in the context of `cmake_install.cmake`.
# That context has an incorrect `CMAKE_BINARY_DIR`
# (which appears to be set to the current directory),
# and is missing other variables that are parameters of this script.
# Therefore, those parameters must be passed from the context
# that calls `install(CODE)`.
# The only parameter that must be taken from `cmake_install.cmake`
# is `CMAKE_INSTALL_PREFIX`, because it can change at install time.

set(parameters
  CMAKE_BINARY_DIR
  PACKAGE_NAME
  CONFIG
  CMAKE_PREFIX_PATH
  CMAKE_MODULE_PATH
  CMAKE_INSTALL_PREFIX
  CUPCAKE_MODULE_DIR
)
foreach(parameter ${parameters})
  if(NOT ${parameter})
    list(APPEND missing_parameters ${parameter})
  endif()
endforeach()
if(missing_parameters)
  message(FATAL_ERROR "missing parameters: ${missing_parameters}")
endif()

message(STATUS "CMAKE_BINARY_DIR = '${CMAKE_BINARY_DIR}'")
message(STATUS "PACKAGE_NAME = '${PACKAGE_NAME}'")
message(STATUS "CONFIG = '${CONFIG}'")
message(STATUS "CMAKE_PREFIX_PATH = '${CMAKE_PREFIX_PATH}'")
message(STATUS "CMAKE_MODULE_PATH = '${CMAKE_MODULE_PATH}'")
message(STATUS "CMAKE_INSTALL_PREFIX = '${CMAKE_INSTALL_PREFIX}'")
message(STATUS "CUPCAKE_MODULE_DIR = '${CUPCAKE_MODULE_DIR}'")

set(tmp_dir "${CMAKE_BINARY_DIR}/cpp_info")
file(REMOVE_RECURSE "${tmp_dir}")
file(MAKE_DIRECTORY "${tmp_dir}")
execute_process(
  COMMAND "${CMAKE_COMMAND}"
    "-DPACKAGE_NAME=${PACKAGE_NAME}"
    "-DCONFIG=${CONFIG}"
    # CMake complains if `CMAKE_BUILD_TYPE` is not set for
    # single-configuration generators.
    "-DCMAKE_BUILD_TYPE=${CONFIG}"
    "-DCMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}"
    "-DCMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}"
    "-DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}"
    "${CUPCAKE_MODULE_DIR}/data/project_cpp_info"
  WORKING_DIRECTORY "${tmp_dir}"
)

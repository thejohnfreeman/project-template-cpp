cmake_minimum_required(VERSION 3.16)

set(PROJECT_DESCRIPTION "\
An example project that does not use cupcake \
but imports another project that did when it was installed.\
")

project(eleven
  VERSION 0.1.0
  DESCRIPTION "${PROJECT_DESCRIPTION}"
  HOMEPAGE_URL https://github.com/thejohnfreeman/project-template-cpp
  LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/output/$<CONFIG>/bin")
set(CMAKE_BUILD_RPATH_USE_ORIGIN TRUE)
set(CMAKE_INSTALL_RPATH \$ORIGIN \$ORIGIN/../lib)

# dependencies {
find_package(zero REQUIRED)
# }

add_library(libeleven src/libeleven.cpp)
target_include_directories(libeleven PUBLIC include)
if(BUILD_SHARED_LIBS)
  target_compile_definitions(libeleven PRIVATE ELEVEN_EXPORTS)
else()
  target_compile_definitions(libeleven PUBLIC ELEVEN_STATIC)
endif()
target_link_libraries(libeleven PUBLIC zero::libzero)

add_executable(eleven src/eleven.cpp)
target_link_libraries(eleven PRIVATE libeleven)

install(
  TARGETS eleven libeleven
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
)

include(CTest)
if(BUILD_TESTING)
  add_subdirectory(tests)
endif()

if(FUTURE_INSTALL_DIRS)
  return()
endif()
set(FUTURE_INSTALL_DIRS TRUE)
message(STATUS "WIN32 = ${WIN32}")
if(WIN32)
  # On Windows, everything just gets thrown into the same directory.
  set(CMAKE_INSTALL_INCLUDEDIR .)
  set(CMAKE_INSTALL_LIBDIR .)
  set(CMAKE_INSTALL_BINDIR .)
  foreach(dir INCLUDEDIR LIBDIR BINDIR)
    set(CMAKE_INSTALL_FULL_${dir}
      ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_${dir}})
  endforeach()
else()
  include(GNUInstallDirs)
endif()
# Installed executables should be able to find installed shared libraries by
# default.
set(CMAKE_INSTALL_RPATH ${CMAKE_INSTALL_FULL_LIBDIR})

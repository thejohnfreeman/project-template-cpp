if(WIN32)
  # On Windows, everything just gets thrown into the same directory.
  set(CMAKE_INSTALL_LIBDIR)
  set(CMAKE_INSTALL_BINDIR)
else()
  include(GNUInstallDirs)
endif()

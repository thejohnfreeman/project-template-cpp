cmake_minimum_required(VERSION 3.11)

project(LANGUAGES CXX)

message(STATUS "searching for '${PACKAGE_NAME}' under '${CMAKE_INSTALL_PREFIX}'")
find_package(
  ${PACKAGE_NAME}
  REQUIRED
  NO_DEFAULT_PATH
  PATHS ${CMAKE_INSTALL_PREFIX}
)

# declare_libraries(<output> [<target>...])
#
# For each library target, add Python statements to the output variable
# to declare these properties on a component named after the target:
#
# - requires: list of linked target names
# - includedirs: list of include directories relative to the install prefix
# - defines: list of "name=value" definitions
# - cflags: list of non-definition compiler options (for C libraries)
# - cxxflags: list of non-definition compiler options (for C++ libraries)
# - sharedlinkflags: list of linker flags
# - libs: singleton list of installed library name to be searched by linker
# - libdirs: singleton list of directory, relative to the install prefix, where library installed
function(declare_libraries output)
  set(target_pattern "^([^:]+)::(.+)$")

  foreach(target ${ARGN})
    # Peel off the namespace to get the unqualified CMake target name
    # which we'll use as the Conan component name.
    string(REGEX MATCH "${target_pattern}" match ${target})
    if(CMAKE_MATCH_1 STREQUAL PACKAGE_NAME)
      set(name ${CMAKE_MATCH_2})
    else()
      message(FATAL_ERROR "foreign target: '${target}'")
    endif()

    string(APPEND tail
      # - names[generator]: unqualified target name
      "self.components['${name}'].names['cmake_find_package'] = '${name}'\n"
      "self.components['${name}'].names['cmake_find_package_multi'] = '${name}'\n"
      # - set_property('cmake_target_name'): qualified target name
      "self.components['${name}'].set_property('cmake_target_name', '${target}')\n"
    )

    get_target_property(links ${target} INTERFACE_LINK_LIBRARIES)
    if(links)
      unset(requires)
      foreach(link ${links})
        if(NOT TARGET ${link})
          message(STATUS "ignoring non-target link '${link}' of target '${target}'")
          continue()
        endif()
        # TODO: We could try to distinguish internal vs external libraries by
        # whether they are imported, but that would not work when taking
        # dependencies by add_subdirectory unless we install their libraries as
        # internal libraries.
        string(REGEX MATCH "${target_pattern}" match ${link})
        if(CMAKE_MATCH_1 STREQUAL PACKAGE_NAME)
          set(lname ${CMAKE_MATCH_2})
        else()
          get_target_property(lname ${link} ALIASED_TARGET)
          if(NOT lname)
            set(lname ${link})
          endif()
        endif()
        string(APPEND requires "'${lname}',")
      endforeach()
      string(APPEND tail
        "self.components['${name}'].requires = [${requires}]\n"
      )
    endif()

    get_target_property(directories ${target} INTERFACE_INCLUDE_DIRECTORIES)
    if(directories)
      foreach(directory ${directories})
        file(RELATIVE_PATH relative "${CMAKE_INSTALL_PREFIX}" "${directory}")
        # TODO: Cannot start with `..`.
        string(APPEND includedirs "'${relative}',")
      endforeach()
      if(NOT includedirs STREQUAL "'include',")
        string(APPEND tail
          "self.components['${name}'].includedirs = [${includedirs}]\n"
        )
      endif()
    endif()

    get_target_property(definitions ${target} INTERFACE_COMPILE_DEFINITIONS)
    if(definitions)
      foreach(definition ${definitions})
        string(APPEND defines "'${definition}',")
      endforeach()
      string(APPEND tail
        "self.components['${name}'].defines = [${defines}]\n"
      )
    endif()

    get_target_property(options ${target} INTERFACE_COMPILE_OPTIONS)
    if(options)
      foreach(option ${options})
        string(APPEND cxxflags "'${option}',")
      endforeach()
      string(APPEND tail
        "self.components['${name}'].cxxflags = [${cxxflags}]\n"
      )
    endif()

    # LINK_FLAGS until CMake 3.13, then LINK_OPTIONS.
    get_target_property(options ${target} LINK_OPTIONS)
    if(NOT options)
      get_target_property(options ${target} LINK_FLAGS)
    endif()
    if(options)
      foreach(option ${options})
        string(APPEND sharedlinkflags "'${option}',")
      endforeach()
      string(APPEND tail
        "self.components['${name}'].sharedlinkflags = [${sharedlinkflags}]\n"
      )
    endif()

    get_target_property(location ${target} IMPORTED_LOCATION_${CONFIG})
    # Skip header-only libraries.
    if(location)
      get_filename_component(lib "${location}" NAME)
      get_filename_component(libdir "${location}" DIRECTORY)
      file(RELATIVE_PATH libdir "${CMAKE_INSTALL_PREFIX}" "${libdir}")
      string(APPEND tail
        "self.components['${name}'].libs = ['${lib}']\n"
      )
      if(NOT libdir STREQUAL "lib")
        string(APPEND tail
          "self.components['${name}'].libdirs = ['${libdir}']\n"
        )
      endif()
    endif()
  endforeach()

  set(${output} "${${output}}${tail}" PARENT_SCOPE)
endfunction()

string(APPEND cpp_info
  # - names[generator]: namespace name
  "self.names['cmake_find_package'] = '${PACKAGE_NAME}'\n"
  "self.names['cmake_find_package_multi'] = '${PACKAGE_NAME}'\n"
  # - filenames[generator]: Config Module filename
  "self.filenames['cmake_find_package'] = '${PACKAGE_NAME}'\n"
  "self.filenames['cmake_find_package_multi'] = '${PACKAGE_NAME}'\n"
  # - set_property('cmake_file_name'): Config Module filename
  "self.set_property('cmake_file_name', '${PACKAGE_NAME}')\n"
  # - set_property('cmake_find_mode'): 'config'
  "self.set_property('cmake_find_mode', 'config')\n"
)

declare_libraries(cpp_info ${${PACKAGE_NAME}_LIBRARIES})

file(GENERATE
  OUTPUT "${CMAKE_INSTALL_PREFIX}/share/${PACKAGE_NAME}/cpp_info.py"
  CONTENT "${cpp_info}"
)

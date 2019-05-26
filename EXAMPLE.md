We have a Library and an Example.

We have tested the Example as a **CMake project**: a "full" `CMakeLists.txt`
with a `project` command and a `find_package` command that expects to find the
Library installed on the system. We have installed the Library to a custom
prefix (not `/usr/`) and successfully built the Example, once by setting
`CMAKE_INSTALL_PREFIX` (which does double duty, indicating both "install the
Example here" and "search for the Example's dependencies here"), and once by
setting `CMAKE_PREFIX_PATH` (which only indicates the latter).

We have tested the Example as a **CMake and Conan project**: the same full
`CMakeLists.txt` from before plus a `conanfile.txt` listing the Library as
a requirement and using the `cmake_find_package` generator. We installed the
Library with Conan and successfully built the Example by setting
`CMAKE_MODULE_PATH`, which let CMake find the Library through the
`FindLibrary.cmake` file that Conan generated.

NOTE: Conan's package configuration file only exports one target, named after
the package, scoped within a namespace named after the package. The only
reason we can use the same `CMakeLists.txt` whether we use Conan or not is
because the project follows the same convention for its package configuration
file. Many packages reasonably want to export multiple **components**, which
necessitates multiple targets with different names. I am not yet clear what
is Conan's direction on this issue.

We can test the Example as a **CMake subdirectory**: a "partial"
`CMakeLists.txt` that has no `project` command and may or may not use
`find_package` before linking against the Library with
`target_link_libraries`. For this test, we need another `CMakeLists.txt`
(which must exist in another directory) that calls `project` and includes the
Example through `add_subdirectory` (which can take an absolute path).

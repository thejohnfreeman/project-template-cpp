# cupcake

cupcake is a CMake module.

## Install

The recommended method to import cupcake is `find_package()`:

```cmake
find_package(cupcake 0.1.0 REQUIRED)
```

Unlike [`include()`][include], [`find_package()`][find_package] lets us easily
check version compatibility and lean on package managers like Conan.
For that to work, an installation must be found on the
[`CMAKE_PREFIX_PATH`][CMAKE_PREFIX_PATH].
There are a few ways to accomplish that.

### Install from Conan

First, you need to tell Conan how to find cupcake.
You can either:

- Point it to my public [Artifactory][]:

    ```shell
    conan remote add jfreeman https://jfreeman.jfrog.io/artifactory/api/conan/default-conan
    ```

- Copy the recipe from this project:

    ```shell
    conan export .
    ```

Then add `cupcake/0.1.0` as a non-tool requirement to your conanfile:

```
requires = ['cupcake/0.1.0']
```

[Tool requirements][tool_requires] cannot [modify][6] the `CMAKE_PREFIX_PATH`
as of 2023-02-02.

### Install manually

```shell
# In this project:
cmake -B .build -DCMAKE_INSTALL_PREFIX=<path> .
cmake --build .build --target install
# In your project:
cmake -B .build -DCMAKE_PREFIX_PATH=<path> .
```

### Install as submodule

Alternatively, you can embed this project in yours as a submodule and import
it with [`add_subdirectory()`][add_subdirectory]:

```cmake
add_subdirectory(path/to/cupcake)
```


## Interface

- [`cupcake_project`](#cupcake_project)
- [`cupcake_find_package`](#cupcake_find_package)
- [`cupcake_add_subproject`](#cupcake_add_subproject)
- [`cupcake_add_library`](#cupcake_add_library)
- [`cupcake_add_executable`](#cupcake_add_executable)
- [`cupcake_add_tests`](#cupcake_add_tests)
- [`cupcake_add_test_executable`](#cupcake_add_test_executable)
- [`cupcake_install_project`](#cupcake_install_project)
- [`cupcake_install_cpp_info`](#cupcake_install_cpp_info)


### `cupcake_project`

```
cupcake_project()
```

Define project variables used by other cupcake commands,
and choose different defaults for built-in CMake commands.

`cupcake_project()` must be called after a call of the built-in CMake command
[`project()`][project] and before any other cupcake commands in that project.
It takes no arguments directly, instead taking them all from the variables set
by the call to `project()`.
I would have liked this command to wrap the call to `project()`, if possible,
but CMake [requires][1] a "literal, direct call to the `project()` command" in
the top-level `CMakeLists.txt`, and thus it cannot be wrapped.


### `cupcake_find_package`

```
cupcake_find_package(<package-name> <version> [PRIVATE] ...)
```

Import targets for a dependency by calling [`find_package()`][find_package].

`<version>` is forwarded to `find_package()`,
but note that it is a required parameter for this command.

In the underlying call to `find_package()`,
`REQUIRED` is always passed so that missing dependencies raise an error.
Optional dependencies should always be guarded by an option, rather than
conditionally linking based on whether or not CMake succeeded in finding them.

Unless `PRIVATE` is passed, this call saves the package name and version
in a list of dependencies for the project.
That list affects the behavior of `cupcake_install_project()`:
the generated package configuration file will transitively call
[`find_dependency()`][find_dependency] for all non-private dependencies.

Additional arguments are passed through to `find_package()`.


### `cupcake_add_subproject`

```
cupcake_add_subproject(<name> [PRIVATE] [<path>])
```

Import targets for a dependency by calling
[`add_subdirectory()`][add_subdirectory].

`<path>` is forwarded to `add_subdirectory()` as the `<source_dir>` argument.
If it is absent, then `<name>` is used instead.
Relative paths, like the subproject name,
are relative to [`CMAKE_CURRENT_SOURCE_DIR`][CMAKE_CURRENT_SOURCE_DIR].

`<name>` should match the name passed to the [`project()`][project] command in
the `CMakeLists.txt` of the subdirectory.

`PRIVATE` has the same meaning as it does for
[`cupcake_find_package()`](#cupcake_find_package).


### `cupcake_add_library`

```
cupcake_add_library(<name>)
```

Add a target for an exported library by calling [`add_library`][add_library].

The target will be named `${PROJECT_NAME}::lib<name>`,
i.e. `lib<name>` scoped under the project name.
That target will be an [`ALIAS` target][3].
All target references should use their scoped names, where possible,
for consistency between internal and external targets.
Scoped names can only be aliases, but not all commands accept alias targets,
e.g. in the first argument of
[`target_link_libraries()`][target_link_libraries].
This command defines a variable in the parent scope, `this`, with the name of
the unaliased target for convenient use in such commands.
Those commands should be called immediately after this one,
to keep all of a target's configuration in one place.

A library's public, exported headers should be either
the single file `include/<name>.h`
or every file under the directory `include/<name>`.
Private, unexported headers may be placed under `src/lib<name>`.
If a library has sources, they should be either
the single file `src/lib<name>.cpp`
or every `.cpp` file under the directory `src/lib<name>`.
If a library does not have sources, i.e. if it is a header-only library,
then the target will be an [`INTERFACE` library][4].
If a library does have sources, then the target will be a
[`STATIC` or `SHARED` library][5] depending on the value of variable
[`BUILD_SHARED_LIBS`][BUILD_SHARED_LIBS].


### `cupcake_add_executable`

```
cupcake_add_executable(<name>)
```

Add a target for an exported executable by calling
[`add_executable`][add_executable].

The target will be named `${PROJECT_NAME}::<name>`,
i.e. `<name>` scoped under the project name.
The variable `this` is defined in the parent scope just as it is by
[`cupcake_add_library()`](#cupcake_add_library) and for the same reason.

An executable must have sources, and they should be either
the single file `src/<name>.cpp`
or every `.cpp` file under the directory `src/<name>`.

### `cupcake_add_tests`

```
cupcake_add_tests()
```

Conditionally adds tests to the project.

The command does nothing if the project is not top-level.
Dependents generally want to run a dependency's tests only when the dependency
is installed, if at all, not every time the dependent runs its own tests.

If the project is top-level, then the command imports the [CTest module][].
If [`BUILD_TESTING`][CTest module] is `ON`, which it is by default,
then the command calls [`add_subdirectory(tests)`][add_subdirectory].

Individual tests should be added in the `CMakeLists.txt` of the `tests`
subdirectory.
Dependencies that only the tests should be imported there too.


### `cupcake_add_test_executable`

```
cupcake_add_test_executable(<name>)
```

Add a target for a test executable.

This command should be called only from `tests/CMakeLists.txt`.
All relative paths mentioned here are relative to `tests/`.

The target is given an unspecified name.
The variable `this` is defined in the parent scope just as it is by
[`cupcake_add_library()`](#cupcake_add_library) and for the same reason.

A test executable must have sources, and they should be either
the single file `<name>.cpp`
or every `.cpp` file under the directory `<name>`.

Test executables are not exported.
They are added to the list of tests run by CTest.

The target is excluded from the ["all" target][EXCLUDE_FROM_ALL].
This way, resources are not spent building tests unless they are run.
Tests are re-built if necessary when run.


### `cupcake_install_project`

```
cupcake_install_project()
```

Install all exported targets.

This command should be called only once,
after all exported targets have been added.

After installation, dependents can import all exported targets,
under the same scoped names,
with [`cupcake_find_package()`](#cupcake_find_package)
by passing the name of the project and
a version string compatible under semantic versioning.


### `cupcake_install_cpp_info`

```
cupcake_install_cpp_info()
```

Install package metadata for Conan.

This command adds an installation rule to install a Python script at
`${CMAKE_INSTALL_PREFIX}/share/<PackageName>/cpp_info.py`.
That script can be executed within the [`package_info()`][package_info] method
of a Python conanfile to [fill in the details][2] of the
[`cpp_info`][cpp_info] attribute:

```python
def package_info(self):
    path = f'{self.package_folder}/share/{self.name}/cpp_info.py'
    with open(path, 'r') as file:
        exec(file.read(), {}, {'self': self.cpp_info})
```


## Example

```cmake
# CMakeLists.txt
cmake_minimum_required(VERSION 3.7)
project(package_name LANGUAGES CXX)
find_package(cupcake 0.1.0 REQUIRED)
cupcake_project()
cupcake_find_package(dependency_name 1.0)
cupcake_add_library(library_name)
target_link_libraries(${this} PUBLIC dependency_name::target_name)
cupcake_add_executable(executable_name)
target_link_libraries(${this} PUBLIC package_name::library_name)
cupcake_add_tests()
cupcake_install_project()
```

```cmake
# tests/CMakeLists.txt
cupcake_find_package(test_dependency_name 1.0)
cupcake_add_test_executable(test_name)
target_link_libraries(${this}
    test_dependency_name::target_name
    package_name::library_name
)
```

[BUILD_SHARED_LIBS]: https://cmake.org/cmake/help/latest/variable/BUILD_SHARED_LIBS.html
[CMAKE_CURRENT_SOURCE_DIR]: https://cmake.org/cmake/help/latest/variable/CMAKE_CURRENT_SOURCE_DIR.html
[CMAKE_PREFIX_PATH]: https://cmake.org/cmake/help/latest/variable/CMAKE_PREFIX_PATH.html
[EXCLUDE_FROM_ALL]: https://cmake.org/cmake/help/latest/prop_tgt/EXCLUDE_FROM_ALL.html#prop_tgt:EXCLUDE_FROM_ALL
[add_executable]: https://cmake.org/cmake/help/latest/command/add_executable.html
[add_library]: https://cmake.org/cmake/help/latest/command/add_library.html
[add_subdirectory]: https://cmake.org/cmake/help/latest/command/add_subdirectory.html
[find_package]: https://cmake.org/cmake/help/latest/command/find_package.html
[find_dependency]: https://cmake.org/cmake/help/latest/module/CMakeFindDependencyMacro.html
[include]: https://cmake.org/cmake/help/latest/command/include.html
[project]: https://cmake.org/cmake/help/latest/command/project.html
[target_link_libraries]: https://cmake.org/cmake/help/latest/command/target_link_libraries.html
[CTest module]: https://cmake.org/cmake/help/latest/module/CTest.html

[Artifactory]: https://docs.conan.io/1/uploading_packages/using_artifactory.html
[cpp_info]: https://docs.conan.io/1/reference/conanfile/attributes.html#cpp-info
[package_info]: https://docs.conan.io/1/reference/conanfile/methods.html#package-info
[tool_requires]: https://docs.conan.io/1/devtools/build_requires.html
[requires]: https://docs.conan.io/1/reference/conanfile/attributes.html#requires

[1]: https://cmake.org/cmake/help/latest/command/project.html#usage
[2]: https://docs.conan.io/1/creating_packages/package_information.html
[3]: https://cmake.org/cmake/help/latest/command/add_library.html#alias-libraries
[4]: https://cmake.org/cmake/help/latest/command/add_library.html#interface-libraries
[5]: https://cmake.org/cmake/help/latest/command/add_library.html#normal-libraries
[6]: https://github.com/conan-io/conan/issues/13036

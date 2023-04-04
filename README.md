# project-template-cpp

This is a collection of example C++ projects demonstrating:

- A standard directory structure.
- Concise configurations for [CMake] and [Conan].
- A variety of popular methods for importing dependencies.

[CMake]: https://cmake.org/cmake/help/latest/manual/cmake.1.html
[Conan]: https://docs.conan.io/

Each project defines one package named after the number in its directory name,
e.g. `zero`, `one`, `two`, etc.
[`cupcake`](./cupcake) is a special package that only exports a CMake module.


## Structure

Each package follows a strict structure that brings a few benefits:

- Newcomers can quickly orient themselves to a package.
- Contributors don't have to spend any time thinking about where to place new
    files.
- Tools can make assumptions that let them handle as much heavy lifting and
    boilerplate for users as possible.

Each package is a collection of:

- Zero or more **libraries**. Each library has **public headers**.
- Zero or more **executables**.
- At least one library or executable.
- Zero or more **tests**.
    Each test is an executable that returns 0 if and only if it passed.

The package and each library, executable, and test must have a name.
Every appearance of `{name}` in this document refers to that name, in context.
These names must use only lowercase letters
(to avoid any problems with case-insensitive filesystems),
and numbers,
and must start with a letter
(to avoid any problems with their use as an identifier).
Separators are prohibited (for now).
If you find yourself wanting a separator,
consider using an initialism for the name instead,
like `gmp` for the [**G**NU **M**ultiple **P**recision Arithmetic Library][gmp]
or `mpfr` for the [**M**ultiple **P**recision **F**loating-Point **R**eliable Library][mpfr].

[gmp]: https://en.wikipedia.org/wiki/GNU_Multiple_Precision_Arithmetic_Library
[mpfr]: https://en.wikipedia.org/wiki/GNU_MPFR

Conventionally, the name of the main library (if any) and main executable (if
any) should match the name of the package.
For example, a package named `curl` might have a library named `curl` and an
executable named `curl`.

Each package has a "physical" structure in the filesystem
and a "logical" structure in its CMake configuration.


### Physical

```
/
|- conanfile.py
|- CMakeLists.txt
|- external/
|  `- Finddoctest.cmake
|- include/
|  `- example/
|     `- example.hpp
|- src/
|  |- libexample.cpp
|  `- example.cpp
`- tests/
   |- CMakeLists.txt
   `- main.cpp
```

Each library must have at least one public header.[^1]
Public headers are located under the `include` directory.
A library may have a single public header in that directory named `{name}.hpp`,
or a directory named `{name}` with many public headers
A library with many public headers must put them under a directory named
`{name}`.
A library with a header directory must not have headers in that directory
named `version.hpp` or `export.hpp` because they will be generated.

A library may have source files (i.e. implementation files ending with
extension `.cpp`).
A library without sources is called header-only.
A library with sources must put them under the `src` directory.
A library with a single source file must name it `lib{name}.cpp`.
A library with many sources must put them under a directory named `lib{name}`.
A library may have private headers.
They should be placed under its source directory.

An executable is much like a library except that
(a) it must not have public headers,
(b) it must have sources,
and (c) it must drop the `lib` prefix for its source file or directory.

Each test is much like an executable except that
its sources must be placed under the `tests` directory.


### Logical

The root directory of a project must have a `CMakeLists.txt`.
That listfile must define a CMake project with the package name.

The root listfile must define a target for each library.
A library's target must be named `lib{name}`.
If the library is header-only, then the target must be an
[`INTERFACE` library][2].
Otherwise, its linkage must be determined by the value of
[`BUILD_SHARED_LIBS`].

The root listfile must define a target for each executable.
An executable's target must be named `{name}`.

The root listfile must define an `ALIAS` target
nested under the package scope
for each [library][3] and [executable][4].
That is, it must be named `{package-name}::{target-name}`.
All target references, e.g. in calls to `target_link_libraries`,
must use these `ALIAS` targets.

The root listfile must import the direct dependencies of all libraries and
executables with [`find_package`].
(See section [Imports](#imports) below.)
It must not import any dependencies that are not directly used in the root
listfile, e.g. dependencies that are only used by tests.

The root listfile must install every library and executable,
all public headers,
and [Package Configuration Files][PCF] for all library and executable targets.
The exported target names must match the `ALIAS` names.

If the project has tests,
then the root listfile must call `add_subdirectory(tests)` only when testing
is enabled, i.e. when the [`BUILD_TESTING`] option is `ON` (the default).
The `tests` directory must have a `CMakeLists.txt`.
The tests listfile must define a [CMake test][5] for each test.
It must import the direct dependencies of all tests with `find_package`.

Any target defined in the tests listfile must be
[excluded][`EXCLUDE_FROM_ALL`] from the `ALL` target.
The tests listfile must not directly or indirectly
[install][`install`] anything.


## Imports

Every project has direct dependencies,
and some have indirect dependencies.
Every project finds its direct dependencies via calls to [`find_package`].
`find_package` lets builders hook into the import
by supplying their own [Find Module (FM)][FM] at build time, if desired.
By default, a call to `find_package` looks for
a [Package Configuration File (PCF)][PCF] first
(on the [`CMAKE_PREFIX_PATH`] and friends)
and an FM second (on the [`CMAKE_MODULE_PATH`]).[^2]
When a PCF exists for a package, we say that package is **installed**.

Every project that does not expect to find a PCF for a dependency 
defines its own FM for that dependency.
These FMs are effectively fallbacks or defaults,
used when the builder does not supply their own FMs.
They demonstrate a variety of different methods for importing,
including [`add_subdirectory`], [`FetchContent`], and [`ExternalProject`].

Once a package is installed,
its PCF is responsible for importing its direct dependencies.
These PCFs all use `find_package` too.[^3]
A package's PCF cannot build its direct dependencies,
and thus it cannot use the same import methods
that it might have used in its FMs,
e.g. `add_subdirectory` or `FetchContent`.
A project that needed to build a dependency
because it could not find it installed
should install that dependency when it installs itself,
so that its PCF can find the dependency installed.

Every project,
with one exception explained below,
imports [`doctest`] and [`cupcake`](./cupcake) via PCF.
All but `zero` directly import one of the other projects, too,
using one of the known import methods.
The package relationships are contrived to test a number of combinations of
import methods for direct and indirect dependencies.
The dependency relationships and import methods are captured in the table
below.
Special notes on select projects follow.

Package | Direct Dependencies | Indirect Dependencies | Required Installation
---|---|---|---
[`zero`](./00-upstream) |
[`one`](./01-find-package) | `zero` via [PCF] | | `zero` |
[`two`](./02-add-subdirectory) | `zero` via [`add_subdirectory`] |
[`three`](./03-fp-fp) | `one` via PCF | `zero` | `one`, `zero` |
[`four`](./04-as-fp) | `two` via PCF | `zero` | `two` |
[`five`](./05-fetch-content) | `zero` via [`FetchContent`] |
[`six`](./06-fp-fc) | `one` via `FetchContent` | `zero` | `zero` |
[`seven`](./07-as-fc) | `two` via `FetchContent` | `zero` |
[`eight`](./08-find-module) | `zero` via [`find_library`] | | `zero` |
[`nine`](./09-external-project) | `zero` via [`ExternalProject`] |
[`ten`](./10-conan) | `zero` via [`find_conan_packages`] |
[`eleven`](./11-no-cupcake) | `zero` via PCF |

- `zero`: Imports no other packages from this collection.
- `two`:
    Requires that `zero` be in the subdirectory `external/00-upstream`.
    Installs `zero` when it is installed so that packages depending on `two`
    do not have to know about indirect dependencies.
- `eight`: Imports `zero` via `find_package`,
    which finds an FM at `external/Findzero.cmake`,
    which uses [`find_path`], [`find_library`], and [`find_program`]
    to define [`IMPORTED`] targets.
- `ten`: [`find_conan_packages`] is an undocumented, experimental function in
    `cupcake`.
    The idea is to import every requirement listed in the package's
    `conanfile.txt`.
    Although it is possible, I'm not convinced that it is wise.
- `eleven`: Does not import `cupcake`, unlike all of the other projects.
    This package tests that consumers do not need `cupcake` to import
    a package that uses `cupcake`.

[^1]: Correct me if I'm wrong, but a library without public headers would be
  useless. No one would be able to import any of its exports.
[^2]: This is not the CMake default, which looks for FMs first.
Instead, it is the default behavior chosen by `cupcake`.
[^3]: Technically, [`find_dependency`].
[^4]: The abbreviations in directory names indicate the import methods used,
  and their order: `fp` = [`find_package`], `as` = [`add_subdirectory`],
  `fc` = [`FetchContent`].

[`doctest`]: https://github.com/doctest/doctest
[`find_package`]: https://cmake.org/cmake/help/latest/command/find_package.html
[`find_dependency`]: https://cmake.org/cmake/help/latest/module/CMakeFindDependencyMacro.html
[`add_subdirectory`]: https://cmake.org/cmake/help/latest/command/add_subdirectory.html
[`FetchContent`]: https://cmake.org/cmake/help/latest/module/FetchContent.html
[`ExternalProject`]: https://cmake.org/cmake/help/latest/module/ExternalProject.html
[`CMAKE_PREFIX_PATH`]: https://cmake.org/cmake/help/latest/variable/CMAKE_PREFIX_PATH.html
[`CMAKE_MODULE_PATH`]: https://cmake.org/cmake/help/latest/variable/CMAKE_MODULE_PATH.html
[`CMAKE_INSTALL_PREFIX`]: https://cmake.org/cmake/help/latest/variable/CMAKE_INSTALL_PREFIX.html
[`CMAKE_SYSTEM_PREFIX_PATH`]: https://cmake.org/cmake/help/latest/variable/CMAKE_SYSTEM_PREFIX_PATH.html
[`CMAKE_TOOLCHAIN_FILE`]: https://cmake.org/cmake/help/latest/variable/CMAKE_TOOLCHAIN_FILE.html
[`BUILD_SHARED_LIBS`]: https://cmake.org/cmake/help/latest/variable/BUILD_SHARED_LIBS.html
[`BUILD_TESTING`]: https://cmake.org/cmake/help/latest/module/CTest.html
[`EXCLUDE_FROM_ALL`]:https://cmake.org/cmake/help/latest/prop_tgt/EXCLUDE_FROM_ALL.html
[PCF]: https://cmake.org/cmake/help/latest/manual/cmake-packages.7.html#config-file-packages
[FM]: https://cmake.org/cmake/help/latest/manual/cmake-packages.7.html#find-module-packages
[`find_path`]: https://cmake.org/cmake/help/latest/command/find_path.html
[`find_library`]: https://cmake.org/cmake/help/latest/command/find_library.html
[`find_program`]: https://cmake.org/cmake/help/latest/command/find_program.html
[`IMPORTED`]: https://cmake.org/cmake/help/latest/guide/importing-exporting/index.html#importing-targets
[`find_conan_packages`]: ./cupcake/cmake/cupcake_find_conan_packages.cmake
[`install`]: https://cmake.org/cmake/help/latest/command/install.html

[1]: https://cmake.org/cmake/help/latest/manual/cmake-toolchains.7.html
[2]: https://cmake.org/cmake/help/latest/command/add_library.html#interface-libraries
[3]: https://cmake.org/cmake/help/latest/command/add_library.html#alias-libraries
[4]: https://cmake.org/cmake/help/latest/command/add_executable.html#alias-executables
[5]: https://cmake.org/cmake/help/latest/command/add_test.html

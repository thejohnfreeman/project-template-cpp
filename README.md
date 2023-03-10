# project-template-cpp

This is a collection of example C++ projects demonstrating:

- A standard directory structure.
- Concise configurations for [CMake] and [Conan].
- A variety of popular methods for importing dependencies.

[CMake]: https://cmake.org/cmake/help/latest/manual/cmake.1.html
[Conan]: https://docs.conan.io/

Every project defines a package named after the number in its directory name,
e.g. `zero`, `one`, `two`, etc.

## Imports

Every project has direct dependencies,
and some have indirect dependencies.
Every project finds its direct dependencies via calls to [`find_package`].
`find_package` lets builders hook into the import
by supplying their own [Find Module (FM)][FM] at build time, if desired.
By default, a call to `find_package` looks for
a [Package Configuration File (PCF)][PCF] first
(on the [`CMAKE_PREFIX_PATH`] and friends)
and an FM second (on the [`CMAKE_MODULE_PATH`]).[^1]
When a PCF exists for a package, we say that package is **installed**.

[^1]: This is not the CMake default, which looks for FMs first.
Instead, it is the default behavior chosen by `cupcake`.

Every project that does not expect to find a PCF for a dependency 
defines its own FM for that dependency.
These FMs are effectively fallbacks or defaults,
used when the builder does not supply their own FMs.
They demonstrate a variety of different methods for importing,
including [`add_subdirectory`], [`FetchContent`], and [`ExternalProject`].

Once a package is installed,
its PCF is responsible for importing its direct dependencies.
These PCFs all use `find_package` too.[^2]
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
[`eight`](./08-find-module) | `zero` via [`find_library`] |
[`nine`](./09-external-project) | `zero` via [`ExternalProject`] |
[`ten`](./10-conan) | `zero` via [`find_conan_packages`] |
[`eleven`](./11-no-cupcake) | `zero` via PCF

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

[^3]: The abbreviations in directory names indicate the import methods used,
  and their order: `fp` = [`find_package`], `as` = [`add_subdirectory`],
  `fc` = [`FetchContent`].
[^2]: Technically, [`find_dependency`].

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
[PCF]: https://cmake.org/cmake/help/latest/manual/cmake-packages.7.html#config-file-packages
[FM]: https://cmake.org/cmake/help/latest/manual/cmake-packages.7.html#find-module-packages
[`find_path`]: https://cmake.org/cmake/help/latest/command/find_path.html
[`find_library`]: https://cmake.org/cmake/help/latest/command/find_library.html
[`find_program`]: https://cmake.org/cmake/help/latest/command/find_program.html
[`IMPORTED`]: https://cmake.org/cmake/help/latest/guide/importing-exporting/index.html#importing-targets
[`find_conan_packages`]: ./cupcake/cmake/cupcake_find_conan_packages.cmake

[1]: https://cmake.org/cmake/help/latest/manual/cmake-toolchains.7.html

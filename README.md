# project-template-cpp

This is a sample C++ project demonstrating a canonical, minimum-boilerplate
configuration for [CMake][] and [Conan][].

[CMake]: https://cmake.org/cmake/help/latest/manual/cmake.1.html
[Conan]: https://docs.conan.io/

[![build status on Linux and OSX with Travis](https://travis-ci.org/thejohnfreeman/project-template-cpp.svg?branch=master)](https://travis-ci.org/thejohnfreeman/project-template-cpp)


## Quick start

You will need CMake and Conan. CMake is generally installed with your
platform's package manager, or by downloading from its [website][2].
If you do not have Conan, it can be installed easily as a Python package:

```sh
$ pip install conan
```

This project depends on a package of CMake modules, [cmake-future][], that
I publish to my [BinTray repository][1].
Conan will install it for you if you add my repository as a remote:

[cmake-future]: https://github.com/thejohnfreeman/cmake-future

```sh
conan remote add jfreeman https://api.bintray.com/conan/jfreeman/jfreeman
```

Once you have these dependencies, the workflow is easy:

```sh
$ git clone https://github.com/thejohnfreeman/project-template-cpp
$ cd project-template-cpp
$ mkdir build
$ cd build
$ conan install .. --build missing
$ cmake -DCMAKE_TOOLCHAIN_FILE=conan_paths.cmake ..
$ cmake --build .
$ ctest .
```


## Why?

I want to make life easy for the developer of what I'm going to call the
**"Basic C++ Project"**, or BCP. I know some C++ developers just threw up in
their mouths a little reading that, but let me explain.
The Basic C++ Project has these parts:

- A **name** that is a valid C++ identifier.
- Zero or more **public dependencies**. These may be runtime dependencies of
  the library or executables, or they may be build time dependencies of the
  headers. Users must install the public dependencies when they install the
  project.
- Some (public) **headers** nested under a directory named after the project.
- One **library**, named after the project, that can be linked statically or
  dynamically (with no other options). The library depends on the headers and
  the public dependencies.
- Zero or more **examples** that depend on the headers, the library,
  and the public dependencies. These are written as subprojects that can be
  compiled separately, to test the packaging and installation of the library.
- Zero or more **private dependencies**. These are often test frameworks or
  build tools. Developers working on the project expect them to be installed
  for building and testing, but users of the project do not.
- Zero or more **tests** that depend on the headers, the library, the
  public dependencies, and the private dependencies.

As a (returning) C++ developer, I just want to dive into a new project and
start writing code.
I don't want to spend much time setting up the build system.
That said, I want to follow best practices. I want
[conventions](https://en.wikipedia.org/wiki/Convention_over_configuration)
that can fast-track the development of a Basic C++ Project.
I want a project template, like this, that I can mimic<sup id="ref-generator"
name="ref-generator">[1](#fn-generator)</sup>, and unlike so many others,
I want it to be *accessible*:

- It should have absolutely minimal boilerplate. Too much scaffolding feels
  overwhelming and brittle. It becomes too much to understand all at once, and
  makes me worry that any slight change will bring the whole thing down.
  No `CMakeLists.txt` in this project exceeds 13 lines, thanks to the
  abstractions in [cmake-future][]. Instead of repeating long patterns of
  CMake code copied from Stack Overflow, they are encapsulated behind
  well-documented functions with intuitive names.

- It should be well-documented so that newcomers can learn from it.
  If you are left with unanswered questions, please [open an
  issue](https://github.com/thejohnfreeman/project-template-cpp/issues/new) to
  let me know. It is likely someone else will have the same question, and it
  gives me an opportunity to improve the documentation.


<sup id="fn-generator" name="fn-generator">1</sup>
Even better would be a tool that can generate the scaffolding for
a Basic C++ Project. That is in the pipeline.
[↩](#ref-generator)


## Conventions

CMake likes to remind everyone that it is a build system *generator*, not
a *build system*, but it is reaching a level of abstraction that lets us
think of it as a cross-platform build system. It lets us build, test, and
install a project with the same commands on Linux, OSX, and Windows, without
ever knowing what the underlying build system is:

```sh
$ cmake -DCMAKE_BUILD_TYPE=${build_type} "${source_dir}"
$ ncpus=$(python -c 'import multiprocessing as mp; print(mp.cpu_count())')
$ export CMAKE_BUILD_PARALLEL_LEVEL=${ncpus} CTEST_PARALLEL_LEVEL=${ncpus}
$ cmake --build . --config ${build_type}
$ ctest --build-config ${build_type}
$ cmake --build . --config ${build_type} --target install
```

CMake has become the de facto standard in the C++ community. It has entered
a new era of best practices, called **[Modern CMake][]**. At the same time,
there has been an effort to develop a standard C++ project directory structure
named **[Pitchfork][]**. This project tries to follow these popular
conventions and more:

[Modern CMake]: https://www.youtube.com/watch?v=bsXLMQ6WgIk
[Pitchfork]: https://github.com/vector-of-bool/pitchfork

- It uses **[semantic versioning](https://semver.org/)**.
- It installs itself relative to a **prefix**. Headers are
  installed in ``include/``; static and dynamic builds of the library are
  installed in ``lib/``; executables are installed in ``bin/``.
- It installs a **[CMake package configuration file][3]** that exports
  a target for the library. The target is named after the project, and it is
  scoped within a namespace named after the project.


[1]: https://bintray.com/jfreeman/jfreeman
[2]: https://cmake.org/install/
[3]: https://cmake.org/cmake/help/latest/manual/cmake-packages.7.html#package-configuration-file


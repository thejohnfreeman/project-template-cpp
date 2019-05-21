# project-template-cpp

This is a sample C++ project demonstrating a canonical, minimum-boilerplate
configuration for [CMake][].

[CMake]: https://cmake.org/cmake/help/latest/manual/cmake.1.html

[![build status on Linux and OSX with Travis](https://travis-ci.org/thejohnfreeman/project-template-cpp.svg?branch=master)](https://travis-ci.org/thejohnfreeman/project-template-cpp)


## Dependencies

This project depends on abstractions of CMake best practices that I have
packaged as CMake extensions in the project [cmake-future][].

[cmake-future]: https://github.com/thejohnfreeman/cmake-future

```sh
$ curl -L https://raw.githubusercontent.com/thejohnfreeman/cmake-future/master/install.sh \
  | sudo env "PATH=$PATH" bash -s -- master
```

This project installs its dependency ([doctest][]) with the package manager
[Conan][].

[doctest]: https://github.com/onqtam/doctest
[Conan]: https://docs.conan.io/

```sh
$ pip install conan
```


## Quick start

```sh
$ git clone https://github.com/thejohnfreeman/project-template-cpp
$ cd project-template-cpp
$ mkdir build
$ cd build
$ conan install ..
$ cmake -DCMAKE_MODULE_PATH=${PWD} ..
$ cmake --build .
$ ctest .
```


## Why?

I want to make life easy for the developer of what I'm going to call the
**"Basic C++ Project"**. I know some C++ developers just threw up in their
mouths a little reading that, but let me explain.
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
- Zero or more **executables** that depend on the headers, the library,
  and the public dependencies.
- Zero or more **private dependencies**. These are often test frameworks.
  Developers working on the project expect them to be installed for building
  and testing, but users of the project do not.
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
  abstractions in
  [`cmake-future`](https://github.com/thejohnfreeman/cmake-future).

- It should be well documented so that necomers can learn from it.
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
install a project without ever knowing what the underlying build system is:

```sh
$ cmake -DCMAKE_BUILD_TYPE=${build_type} ${source_dir}
$ ncpus=$(python -c 'import multiprocessing as mp; print(mp.cpu_count())')
$ cmake --build . --parallel ${ncpus}
$ ctest --parallel ${ncpus}
$ cmake --build . --target install
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
- It installs a **[CMake package configuration file][PCF]** that exports
  a target for the library. The target is named after the project, and it is
  scoped within a namespace named after the project.

[PCF]: https://cmake.org/cmake/help/latest/manual/cmake-packages.7.html#package-configuration-file

# project-template-cpp

This is a sample C++ project demonstrating canonical, minimum-boilerplate
configurations for [CMake][] and [Conan][].

[CMake]: https://cmake.org/cmake/help/latest/manual/cmake.1.html
[Conan]: https://docs.conan.io

[![build status on Linux and OSX with Travis](https://travis-ci.org/thejohnfreeman/project-template-cpp.svg?branch=master)](https://travis-ci.org/thejohnfreeman/project-template-cpp)


## Why?

I want to make life easy for the developer of what I'm going to call **the
"basic" C++ project**. I know some C++ developers just threw up in their
mouths a little reading that, but let me explain.

The C++ community has a package management problem that is locking out new
developers. Compared to language ecosystems like Rust, JavaScript, and Python,
these *very common* and *totally normal* activities are difficult for even
experienced C++ developers:

- Given an understanding only of their problem, discovering good libraries and
  tools that can solve that problem.
- Installing libraries and tools as per-project dependencies, ready to be
  imported (`#include`d) immediately.
- Packaging and sharing a project so that it can be discovered, installed, and
  imported by others.

The basic C++ project has these parts:

- A library with:
    - Some public headers (`.h` or `.hpp`)
    - Maybe some sources (`.cpp`)
- Maybe an executable tool using that library
- Some tests (executables built from a mix of headers and sources)
- Maybe some build dependencies
- Maybe some runtime dependencies

A new developer should be capable of creating and sharing a basic C++ project.
That means adding and removing dependencies, building and testing, and
packaging and publishing. That last part is key: it needs to close the loop so
that the next project can add this one as a dependency just as easily as it
can [Boost][] or [fmt][].

[Boost]: https://www.boost.org://www.boost.org/
[fmt]: http://fmtlib.net/


## How?

CMake likes to remind everyone that it is a build system *generator*, not
a build system, but it is reaching a level of abstraction that lets users
think of it as a cross-platform build system. It covers three primary use
cases:

```sh
# Build
$ mkdir build
$ cd build
$ cmake ..
$ ncpus=$(python -c 'import multiprocessing; print(multiprocessing.cpu_count())')
$ cmake --build . --config Debug --parallel ${ncpus}

# Test
$ ctest --build-config Debug --parallel ${ncpus}

# Install
$ cmake --config Debug --build . --target install
```

CMake still has a few gaps, the primary one being **multiple configurations**,
e.g. debug vs. release. Some generators (e.g. Visual Studio) natively support
multiple configurations, which lets users defer their choice until build time.
Other generators (e.g. Make and Ninja) require the user to manually create and
manage separate directories for every configuration. CMake could take the
extra step and develop its generators to manage these directories on behalf of
the user.

CMake does not try to tackle the problem of package management, but this is
where Conan steps in. There are other competing package managers (leading
options are [vcpkg][] and [cget][]), but for now Conan is winning in my
opinion (primarily because of its support for binary packages and because of
[conan-center][]). Conan is the closest thing we have right now to NPM, PyPI,
or Maven Central.

[vcpkg]: https://vcpkg.readthedocs.io/
[cget]: https://github.com/pfultz2/cget
[conan-center]: https://bintray.com/conan/conan-center

Conan is much more capable than the basic C++ project requires.

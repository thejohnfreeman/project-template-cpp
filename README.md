# project-template-cpp

This is a sample C++ project demonstrating canonical, minimum-boilerplate
configurations for [CMake][] and [Conan][].

[CMake]: https://cmake.org/cmake/help/latest/manual/cmake.1.html
[Conan]: https://docs.conan.io


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
    - Some public headers (`.h`)
    - Maybe some sources (`.cpp`)
- Maybe an executable tool using that library
- Some tests (executables built from a mix of headers and sources)
- Maybe some build dependencies
- Maybe some runtime dependencies

A new developer should be capable of creating and sharing a basic C++ project.

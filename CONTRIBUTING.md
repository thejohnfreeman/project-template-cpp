These templates are developed in tandem with the [Cupcake][] CMake module.
In fact, that module was originally developed in this repository
before it was extracted to its own separate repository.
It remains in this repository as a submodule at path `/cupcake/`.
See that repository for [instructions][1] on its development.

These templates are the tests for Cupcake.
They depend on package reference `cupcake/alpha@github/thejohnfreeman`.
The tests will fail if that reference is not found.
It is left to the programmer to decide which version of `cupcake`
should be found at that reference, and to put it there.
The easiest way is to just install it from the submodule:

```
conan export cupcake
```

The tests are executed with [pytest][]:

```
poetry run pytest
```

The tests have a few options passed as environment variables:

- `GENERATOR`: The CMake generator to use, e.g. `Ninja`.
- `SHARED`: Whether to build shared libraries (`ON` or `OFF`).
- `FLAVOR`: The build flavor, e.g. `release` or `debug`.


[Cupcake]: https://github.com/thejohnfreeman/cupcake.git
[1]: https://github.com/thejohnfreeman/cupcake/blob/develop/CONTRIBUTING.md
[pytest]: https://docs.pytest.org

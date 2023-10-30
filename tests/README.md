These templates are developed in tandem with the [Cupcake][] CMake module.
In fact, that module was originally developed in this repository
and then extracted to a separate repository.
These templates are the tests for Cupcake.

Before running the tests, ensure that the `cupcake` Conan package
required by these templates is available through Conan,
either in the local cache or on a remote.
You can test a new version of Cupcake by exporting it to the local cache,
or you can test new versions of the templates by removing it.

```
conan export cupcake
poetry run pytest
```

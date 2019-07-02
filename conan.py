from conans import python_requires

CMakeConanFile = python_requires('autorecipes/[*]@jfreeman/testing').cmake()

class Recipe(CMakeConanFile):
    name = CMakeConanFile.__dict__['name']
    version = CMakeConanFile.__dict__['version']
    # Conan complains if we inherit the ``scm`` attribute.
    # This may be resolved in Conan 1.16.
    # https://github.com/conan-io/conan/issues/5181

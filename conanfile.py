from conans import ConanFile, CMake

class Project(ConanFile):
    name = 'project_template'
    license = 'ISC'
    author = 'John Freeman <jfreeman08@gmail.com>'
    url = 'https://github.com/thejohnfreeman/project-template-cpp'
    build_requires = ('doctest/2.3.1@bincrafters/stable',)
    requires = tuple()
    settings = 'arch', 'os', 'compiler', 'build_type'
    options = {'shared': [True, False]}
    default_options = {'shared': False}
    generators = 'cmake_find_package'
    exports_sources = '*'

    def build(self):
        cmake = CMake(self)
        # TODO: Do we need to set the `source_folder`?
        cmake.configure()
        cmake.build()

    def package(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.install()

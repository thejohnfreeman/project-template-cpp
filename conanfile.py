from conans import ConanFile

class Project(ConanFile):
    name = 'project_template'
    license = 'ISC'
    author = 'John Freeman <jfreeman08@gmail.com>'
    url = 'https://github.com/thejohnfreeman/project-template-cpp'
    build_requires = ('doctest/2.3.1@bincrafters/stable',)
    requires = tuple()
    generators = 'cmake_find_package'

from conans import ConanFile

class Project(ConanFile):
    name = 'project_template'
    license = 'ISC'
    author = 'John Freeman <jfreeman08@gmail.com>'
    url = 'https://github.com/thejohnfreeman/project-template-cpp'
    build_requires = tuple()
    generators = 'cmake_find_package'

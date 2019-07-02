import os
from pathlib import Path

from conans import ConanFile, CMake, tools

class Recipe(ConanFile):
    requires = 'future/[>=3.1]@jfreeman/testing',
    executables = 'main',

    # TODO: Add a test recipe to autorecipes. Use everything below.
    settings = 'os', 'compiler', 'build_type', 'arch'
    generators = 'cmake_find_package', 'cmake_paths'

    def build(self):
        # TODO: Pull a smarter `CMake` build helper from `autorecipes` through
        # `python_requires`.
        cmake = CMake(self)
        toolchain_file = Path(self.build_folder) / 'conan_paths.cmake'
        if toolchain_file.is_file():
            cmake.definitions['CMAKE_TOOLCHAIN_FILE'] = str(toolchain_file)
        cmake.configure()
        cmake.build()

    def test(self):
        if not tools.cross_building(self.settings):
            for exe in self.executables:
                self.run(Path(exe).resolve())

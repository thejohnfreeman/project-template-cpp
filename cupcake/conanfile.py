from conans import ConanFile, CMake

class Cupcake(ConanFile):
    name = 'cupcake'
    version = '0.0.0'

    license = 'ISC'
    author = 'John Freeman <jfreeman08@gmail.com>'
    url = 'https://github.com/thejohnfreeman/project-template-cpp'

    settings = []
    options = {}

    exports_sources = 'CMakeLists.txt', 'cupcake-config.cmake.in', 'cmake/*'
    # For out-of-source build.
    # https://docs.conan.io/en/latest/reference/build_helpers/cmake.html#configure
    no_copy_source = True

    def build(self):
        cmake = CMake(self)
        cmake.configure()

    def package(self):
        cmake = CMake(self)
        cmake.install()

    def package_info(self):
        for generator in ('cmake_find_package', 'cmake_find_package_multi'):
            self.cpp_info.build_modules[generator].append(
                'share/cupcake/cupcake-config.cmake'
            )

from conan import ConanFile
from conan.tools.cmake import CMake

class Zero(ConanFile):
    name = 'zero'
    version = '0.1.0'

    license = 'ISC'
    author = 'John Freeman <jfreeman08@gmail.com>'
    url = 'https://github.com/thejohnfreeman/project-template-cpp'

    settings = 'os', 'compiler', 'build_type', 'arch'
    options = {'shared': [True, False], 'fPIC': [True, False]}
    default_options = {'shared': False, 'fPIC': True}

    requires = ['cupcake/0.1.0']
    generators = 'CMakeDeps', 'CMakeToolchain'

    exports_sources = 'CMakeLists.txt', 'cmake/*', 'include/*', 'src/*'
    # For out-of-source build.
    # https://docs.conan.io/en/latest/reference/build_helpers/cmake.html#configure
    no_copy_source = True

    def config_options(self):
        if self.settings.os == 'Windows':
            del self.options.fPIC

    def build(self):
        cmake = CMake(self)
        cmake.configure({
            'BUILD_TESTING': False
        })
        cmake.build()

    def package(self):
        cmake = CMake(self)
        cmake.install()

    def package_info(self):
        path = f'{self.package_folder}/share/{self.name}/cpp_info.py'
        with open(path, 'r') as file:
            exec(file.read(), {}, {'self': self.cpp_info})

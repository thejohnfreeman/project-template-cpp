source_dir := ${PWD}
build_dir := $(abspath build)
install_dir := ${PWD}/../.install/Debug

# As expected, both of these variables work, but for different reasons:
# 1. `CMAKE_INSTALL_PREFIX` says "I intend to install here" and, by default,
# CMake includes `CMAKE_INSTALL_PREFIX` in `CMAKE_SYSTEM_PREFIX_PATH`, which
# is where it searches for dependencies by default.
# 2. `CMAKE_PREFIX_PATH` says "search for my dependencies here in addition to
# `CMAKE_SYSTEM_PREFIX_PATH`".

# prefix_var := CMAKE_INSTALL_PREFIX
prefix_var := CMAKE_PREFIX_PATH

${build_dir} :
	mkdir --parents $@

local : | ${build_dir}
	cd ${build_dir}; cmake \
		-D${prefix_var}=${install_dir} \
		${source_dir}
	cd ${build_dir}; cmake --build . --parallel $(nproc)
	${build_dir}/example

conan : | ${build_dir}
	cd ${build_dir}; conan install ${source_dir}
	cd ${build_dir}; cmake \
		-DCMAKE_MODULE_PATH=${build_dir} \
		${source_dir}
	cd ${build_dir}; cmake --build . --parallel $(nproc)
	${build_dir}/example/example

clean:
	rm --recursive --force ${build_dir}

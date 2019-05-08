# This Makefile assumes Linux and prefers Ninja.
# TODO: We want cross-platform scripts. Once we learn Invoke, we will try it.

GENERATOR ?= Ninja
BUILD_TYPE ?= Debug

build_dir := .build-${BUILD_TYPE}
install_dir := .install-${BUILD_TYPE}

${install_dir} :
	umask 0022; mkdir --parents ${install_dir}/lib/cmake

${build_dir} :
	mkdir ${build_dir}

# The installation directory needs to exist to avoid a warning.
# TODO: Find all CMakeLists.txt to be dependencies of the configuration.
${build_dir}/CMakeCache.txt : CMakeLists.txt | ${build_dir} ${install_dir}
	cd ${build_dir}; conan install \
		--setting "build_type=${BUILD_TYPE}" \
		--build missing \
		..
	cd ${build_dir}; cmake \
		-Wdev -Werror=dev -Wdeprecated -Werror=deprecated \
		-G ${GENERATOR} \
		-DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
		-DCMAKE_INSTALL_PREFIX=../${install_dir} \
		..

configure : ${build_dir}/CMakeCache.txt

build : configure
	cd ${build_dir}; cmake --build . --config ${BUILD_TYPE} -- -j $(shell nproc)

test : configure
	cd ${build_dir}; ctest --build-config ${BUILD_TYPE} --parallel $(shell nproc)

install : configure ${install_dir}
	cd ${build_dir}; cmake --build . --target install

clean :
	rm --recursive --force ${build_dir} ${install_dir}

.PHONY : configure build test install clean

.DEFAULT_GOAL :=

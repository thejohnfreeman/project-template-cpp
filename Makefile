# This Makefile assumes Linux and prefers Ninja.
# TODO: We want cross-platform scripts. Once we learn Invoke, we will try it.

GENERATOR ?= Ninja
BUILD_TYPE ?= Debug

build_dir := .build-${BUILD_TYPE}

${build_dir} :
	mkdir ${build_dir}
	cd ${build_dir}; conan install \
		--setting "build_type=${BUILD_TYPE}" \
		--build missing \
		..
	cd ${build_dir}; cmake \
		-Wdev -Werror=dev -Wdeprecated -Werror=deprecated \
		-G ${GENERATOR} \
		-DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
		..

configure : ${build_dir}

build : ${build_dir}
	cd ${build_dir}; cmake --build . --config ${BUILD_TYPE} -- -j $(shell nproc)

test : ${build_dir}
	cd ${build_dir}; ctest --build-config ${BUILD_TYPE} --parallel $(shell nproc)

clean :
	rm --recursive --force ${build_dir}

.PHONY : build test clean

.DEFAULT_GOAL :=

# This is a cross-platform Makefile.
# It is written to work exactly the same on Linux, OSX, and Windows,
# with CMake as its only dependency.
# In addition to a build system, CMake is used as a cross-platform coreutils,
# with subcommands for, e.g., mkdir, touch, and rm.

ifeq ($(OS),Windows_NT)
	SHELL := powershell.exe
	.SHELLFLAGS :=
	EXE := .exe
	NPROC := $(shell (Get-WmiObject -class Win32_processor).NumberOfLogicalProcessors)
	multi ?= true
else
	SHELL := /bin/bash
	.SHELLFLAGS := -o pipefail -c
	NPROC := $(shell nproc)
endif

.PHONY : run

source_dir := ${CURDIR}
build_dir := ${source_dir}/.build
install_dir ?= ${source_dir}/.install
flavor ?= Release
shared ?= OFF
generator ?= Ninja
options ?=

CMAKE := cmake
CONAN := conan

.DEFAULT_GOAL := test

${build_dir} :
	${CMAKE} -E make_directory $@

${build_dir}/conaninfo.txt : conanfile.txt | ${build_dir}
	${CMAKE} -E chdir ${build_dir} ${CONAN} install ..

conan : ${build_dir}/conaninfo.txt

cache := ${build_dir}/CMakeCache.txt

${cache} : ${build_dir}/conaninfo.txt Makefile | ${build_dir}
	${CMAKE} -E chdir ${build_dir} ${CMAKE} -G "${generator}" -DCMAKE_MODULE_PATH="${build_dir}" -DCMAKE_INSTALL_PREFIX="${install_dir}" $(if ${multi},,-DCMAKE_BUILD_TYPE=${flavor}) -DBUILD_SHARED_LIBS=${shared} ${options} ${source_dir} 2>&1 | tee ${build_dir}/configure.log
	${CMAKE} -E touch $@

configure : ${cache}

config_dir := $(if ${multi},${flavor}/)

built_executable := ${build_dir}/src/${config_dir}executable${EXE}

${built_executable} : ${cache}
	${CMAKE} -E time ${CMAKE} --build ${build_dir} --verbose $(if ${multi},--config ${flavor}) --parallel ${NPROC} --target executable 2>&1 | tee ${build_dir}/build.log
	${SHELL} ${.SHELLFLAGS} "ls -l $@"
	${CMAKE} -E touch $@

build : ${built_executable}

built : ${built_executable}
	$^

force :
	${CMAKE} -E touch ${cache}
	${MAKE} build

test :
	-${CMAKE} -E time ${CMAKE} --build ${build_dir} --target test 2>&1 | tee ${build_dir}/test.log

installed_executable := ${install_dir}/bin/executable${EXE}

${installed_executable} : ${cache}
	${CMAKE} -E time ${CMAKE} --build ${build_dir} --verbose --target install $(if ${multi},--config ${flavor})
	${SHELL} ${.SHELLFLAGS} "ls -l $@"

install : ${installed_executable}

installed : ${installed_executable}
	$^

clean :
	${CMAKE} -E rm -rf ${build_dir}

uninstall :
	${CMAKE} -E rm -rf ${install_dir}

SHELL=/bin/bash -o pipefail

.PHONY :

source_dir := ${CURDIR}
build_dir := ${source_dir}/.build
install_dir := ${source_dir}/../prefix
generator := Ninja
options :=

CMAKE_COMMAND := cmake

.DEFAULT_GOAL := test

${build_dir} :
	mkdir -p $@

${build_dir}/conaninfo.txt : conanfile.txt | ${build_dir}
	cd ${build_dir}; conan install ..

conan : ${build_dir}/conaninfo.txt

${build_dir}/CMakeCache.txt : ${build_dir}/conaninfo.txt Makefile | ${build_dir}
	cd ${build_dir}; ${CMAKE_COMMAND} -G ${generator} \
		-DCMAKE_MODULE_PATH=${build_dir} \
		-DCMAKE_INSTALL_PREFIX=${install_dir} \
		${options} \
		${source_dir} 2>&1 | tee ${build_dir}/configure.log
	touch $@

configure : ${build_dir}/CMakeCache.txt

${build_dir}/src/executable ${build_dir}/tests/tests : ${build_dir}/CMakeCache.txt
	time ${CMAKE_COMMAND} --build ${build_dir} --parallel $(shell nproc) 2>&1 | tee ${build_dir}/build.log
	touch $@

build : ${build_dir}/src/executable

run : ${build_dir}/src/executable
	$^

force :
	touch ${build_dir}/CMakeCache.txt
	${MAKE} build

test : ${build_dir}/tests/tests
	-time ${build_dir}/tests/tests 2>&1 | tee ${build_dir}/test.log

install : ${build_dir}/src/executable
	time ${CMAKE_COMMAND} --build ${build_dir} --target install

clean :
	time ${CMAKE_COMMAND} --build ${build_dir} --target clean

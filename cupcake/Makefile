source_dir := ${CURDIR}
build_dir := ${source_dir}/.build
install_dir ?= ${source_dir}/../.install

CMAKE ?= cmake

.DEFAULT_GOAL := install

${build_dir} :
	${CMAKE} -E make_directory $@

cache := ${build_dir}/CMakeCache.txt

${cache} : Makefile | ${build_dir}
	${CMAKE} -E chdir ${build_dir} ${CMAKE} -DCMAKE_INSTALL_PREFIX="${install_dir}" ${source_dir} 2>&1 | tee ${build_dir}/configure.log
	${CMAKE} -E touch $@

configure : ${cache}

install : ${cache}
	${CMAKE} -E time ${CMAKE} --build ${build_dir} --verbose --target install

clean :
	${CMAKE} -E rm -rf ${build_dir}

uninstall :
	${CMAKE} -E rm -rf ${install_dir}

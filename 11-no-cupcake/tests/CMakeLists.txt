cupcake_find_package(doctest 2.4 PRIVATE)

add_executable(test_eleven eleven.cpp)
target_link_libraries(test_eleven libeleven)
add_test(NAME test_eleven COMMAND test_eleven)

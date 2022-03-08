#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <doctest/doctest.h>

#include <three/three.hpp>

TEST_CASE("three() returns 3") {
    CHECK(three::three() == 3);
}

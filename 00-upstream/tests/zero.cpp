#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <doctest/doctest.h>

#include <zero/zero.hpp>

TEST_CASE("zero() returns 0") {
    CHECK(zero::zero() == 0);
}

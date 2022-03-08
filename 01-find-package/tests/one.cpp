#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <doctest/doctest.h>

#include <one/one.hpp>

TEST_CASE("one() returns 1") {
    CHECK(one::one() == 1);
}

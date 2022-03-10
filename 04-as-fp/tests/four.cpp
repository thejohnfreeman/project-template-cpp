#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <doctest/doctest.h>

#include <four/four.hpp>

TEST_CASE("four() returns 4") {
    CHECK(four::four() == 4);
}

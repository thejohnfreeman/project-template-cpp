#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <doctest/doctest.h>

#include <eight/eight.hpp>

TEST_CASE("eight() returns 8") {
    CHECK(eight::eight() == 8);
}

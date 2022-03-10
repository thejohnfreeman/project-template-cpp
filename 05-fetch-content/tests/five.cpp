#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <doctest/doctest.h>

#include <five/five.hpp>

TEST_CASE("five() returns 5") {
    CHECK(five::five() == 5);
}

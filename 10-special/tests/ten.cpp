#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <doctest/doctest.h>

#include <ten/ten.hpp>

TEST_CASE("ten() returns 10") {
    CHECK(ten::ten() == 10);
}

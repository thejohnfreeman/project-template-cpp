#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <doctest/doctest.h>

#include <nine/nine.hpp>

TEST_CASE("nine() returns 9") {
    CHECK(nine::nine() == 9);
}

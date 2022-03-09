#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <doctest/doctest.h>

#include <two/two.hpp>

TEST_CASE("two() returns 2") {
    CHECK(two::two() == 2);
}

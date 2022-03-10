#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <doctest/doctest.h>

#include <seven/seven.hpp>

TEST_CASE("seven() returns 7") {
    CHECK(seven::seven() == 7);
}

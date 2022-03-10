#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <doctest/doctest.h>

#include <six/six.hpp>

TEST_CASE("six() returns 6") {
    CHECK(six::six() == 6);
}

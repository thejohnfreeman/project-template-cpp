#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <doctest/doctest.h>

#include <zero/zero.hpp>

TEST_CASE("true_() is truthy") {
    CHECK(*zero::true_());
}

TEST_CASE("false_() is falsy") {
    CHECK(!*zero::false_());
}

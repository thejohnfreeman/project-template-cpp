#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <doctest/doctest.h>

#include <ten/ten.hpp>

TEST_CASE("true and true is truthy") {
    CHECK(ten::and_(zero::true_(), zero::true_()));
}

TEST_CASE("false or false is falsy") {
    CHECK(ten::or_(zero::false_(), zero::false_()));
}

TEST_CASE("not false is true") {
    CHECK(*ten::not_(zero::false_()) == *zero::true_());
}

#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <doctest/doctest.h>

#include <one/one.hpp>

TEST_CASE("true and true is truthy") {
    CHECK(one::and_(zero::true_(), zero::true_()));
}

TEST_CASE("false or false is falsy") {
    CHECK(one::or_(zero::false_(), zero::false_()));
}

TEST_CASE("not false is true") {
    CHECK(*one::not_(zero::false_()) == *zero::true_());
}

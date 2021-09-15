#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <doctest/doctest.h>

#include <greetings/greetings.hpp>

TEST_CASE("English greeting is hello") {
    CHECK(greetings::english() == "hello");
}

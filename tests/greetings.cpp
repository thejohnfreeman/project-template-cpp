#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <doctest.h>

#include <greetings/greetings.h>

TEST_CASE("English greeting is hello") {
    CHECK(greetings::english() == "hello");
}

#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <doctest/doctest.h>

#include <diez/diez.hpp>

TEST_CASE("test case please ignore") {
    CHECK(diez::diez() == 10);
}

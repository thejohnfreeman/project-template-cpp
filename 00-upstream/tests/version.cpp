#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <string>
#include <doctest/doctest.h>

#include <zero/version.hpp>

TEST_CASE("version is '0.1.0'") {
    CHECK(std::string(ZERO_VERSION) == "0.1.0");
}

TEST_CASE("major version is 0") { CHECK(ZERO_VERSION_MAJOR == 0); }

TEST_CASE("minor version is 1") { CHECK(ZERO_VERSION_MINOR == 1); }

TEST_CASE("patch version is 0") { CHECK(ZERO_VERSION_PATCH == 0); }

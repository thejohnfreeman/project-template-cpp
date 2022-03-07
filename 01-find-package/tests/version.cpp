#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <string>
#include <doctest/doctest.h>

// Test that the upstream version header was installed correctly.
#include <greetings/version.hpp>

TEST_CASE("version is '0.1.0'") {
    CHECK(std::string(GREETINGS_VERSION) == "0.1.0");
}

TEST_CASE("major version is '0'") {
    CHECK(std::string(GREETINGS_VERSION_MAJOR) == "0");
}

TEST_CASE("minor version is '1'") {
    CHECK(std::string(GREETINGS_VERSION_MINOR) == "1");
}

TEST_CASE("patch version is '0'") {
    CHECK(std::string(GREETINGS_VERSION_PATCH) == "0");
}

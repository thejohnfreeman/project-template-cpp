#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <doctest.h>

#include <project_template.h>

TEST_CASE("greeting is hello") {
    CHECK(project_template::greeting() == "hello");
}

#undef NDEBUG

#include <zero/version.hpp>

#include <cassert>
#include <string>

int main() {
    assert(std::string(ZERO_VERSION) == "0.1.0");
    assert(ZERO_VERSION_MAJOR == 0);
    assert(ZERO_VERSION_MINOR == 1);
    assert(ZERO_VERSION_PATCH == 0);
    return 0;
}

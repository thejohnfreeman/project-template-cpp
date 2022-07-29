#undef NDEBUG

#include <one/one.hpp>

#include <cassert>

int main() {
    assert(one::one() == 1);
    return 0;
}

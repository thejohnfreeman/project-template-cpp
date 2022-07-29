#undef NDEBUG

#include <zero/zero.hpp>

#include <cassert>

int main() {
    assert(zero::zero() == 0);
    return 0;
}

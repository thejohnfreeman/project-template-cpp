#undef NDEBUG

#include <zero/zero.hpp>

#include <cassert>

int main() {
    assert(*zero::true_());
    assert(!*zero::false_());
    return 0;
}

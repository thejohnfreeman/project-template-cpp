#undef NDEBUG

#include <eleven/eleven.hpp>

#include <cassert>

int main() {
    assert(eleven::eleven() == 11);
    return 0;
}

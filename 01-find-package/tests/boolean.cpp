#undef NDEBUG

#include <one/one.hpp>

#include <cassert>

int main() {
    assert(one::and_(zero::true_(), zero::true_()));
    assert(one::or_(zero::false_(), zero::false_()));
    assert(*one::not_(zero::false_()) == *zero::true_());
    return 0;
}

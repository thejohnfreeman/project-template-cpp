#include <ten/ten.hpp>

namespace ten {

unsigned int ten() {
    return 10;
}

zero::Bool and_(zero::Bool a, zero::Bool b) {
    return (*a && *b) ? zero::true_() : zero::false_();
}

zero::Bool or_(zero::Bool a, zero::Bool b) {
    return (*a || *b) ? zero::true_() : zero::false_();
}

zero::Bool not_(zero::Bool a) {
    return (!*a) ? zero::true_() : zero::false_();
}

}

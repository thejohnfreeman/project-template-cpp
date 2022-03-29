#include <one/one.hpp>
#include <six/six.hpp>

namespace six {

unsigned int six() {
    auto const two = one::one() + one::one();
    return two + two + two;
}

}

#include <two/two.hpp>
#include <seven/seven.hpp>

namespace seven {

unsigned int seven() {
    auto const two = two::two();
    return 3 * two + 1;
}

}

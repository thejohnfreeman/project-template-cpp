#include <two/two.hpp>
#include <four/four.hpp>

namespace four {

unsigned int four() {
    return two::two() + two::two();
}

}

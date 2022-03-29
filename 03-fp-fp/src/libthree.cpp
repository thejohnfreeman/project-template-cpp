#include <one/one.hpp>
#include <three/three.hpp>

namespace three {

unsigned int three() {
    return one::one() + one::one() + one::one();
}

}

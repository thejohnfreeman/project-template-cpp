#include <cstdio>

#include <one/one.hpp>
#include <zero/zero.hpp>

int main(int argc, const char** argv) {
    std::printf("hello");
    if (argc > one::one()) {
        std::printf(", %s", argv[1]);
    }
    std::printf("!\n");
    return zero::zero();
}

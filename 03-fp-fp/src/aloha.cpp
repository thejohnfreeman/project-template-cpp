#include <cstdio>

#include <one/one.hpp>

int main(int argc, const char** argv) {
    std::printf("aloha");
    if (argc > one::one()) {
        std::printf(", %s", argv[1]);
    }
    std::printf("!\n");
    return 0;
}

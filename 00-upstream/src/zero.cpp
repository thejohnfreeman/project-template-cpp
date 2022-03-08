#include <zero/zero.hpp>

namespace zero {

unsigned int zero() {
    return 0;
}

class BoxedBool : public Boolean {
private:
    bool value_;
public:
    BoxedBool(bool value) : value_(value) {}
    virtual operator bool() const override {
        return value_;
    }
};

static const BoxedBool TRUE_{true};
static const BoxedBool FALSE_{false};

Bool true_() {
    return &TRUE_;
}

Bool false_() {
    return &FALSE_;
}

}

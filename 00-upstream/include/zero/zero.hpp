#ifndef ZERO_HPP
#define ZERO_HPP

#include <zero/export.hpp>

namespace zero {

ZERO_EXPORT unsigned int zero();

class ZERO_EXPORT Boolean {
public:
    virtual operator bool() const = 0;
};

using Bool = Boolean const*;

ZERO_EXPORT Bool true_();
ZERO_EXPORT Bool false_();

}

#endif

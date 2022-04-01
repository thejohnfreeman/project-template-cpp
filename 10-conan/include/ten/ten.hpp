#ifndef TEN_HPP
#define TEN_HPP

#include <ten/export.hpp>
#include <zero/zero.hpp>

namespace ten {

TEN_EXPORT unsigned int ten();

TEN_EXPORT zero::Bool and_(zero::Bool, zero::Bool);
TEN_EXPORT zero::Bool or_(zero::Bool, zero::Bool);
TEN_EXPORT zero::Bool not_(zero::Bool);

}

#endif

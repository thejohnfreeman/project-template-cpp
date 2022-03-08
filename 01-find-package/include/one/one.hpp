#ifndef ONE_HPP
#define ONE_HPP

#include <one/export.hpp>
#include <zero/zero.hpp>

namespace one {

ONE_EXPORT unsigned int one();

ONE_EXPORT zero::Bool and_(zero::Bool, zero::Bool);
ONE_EXPORT zero::Bool or_(zero::Bool, zero::Bool);
ONE_EXPORT zero::Bool not_(zero::Bool);

}

#endif

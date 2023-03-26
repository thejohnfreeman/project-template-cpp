#ifndef ELEVEN_HPP
#define ELEVEN_HPP

#ifdef WIN32
#  ifdef eleven_libeleven_EXPORTS
     /* We are building this library. */
#    define ELEVEN_EXPORT __declspec(dllexport)
#  else
     /* We are importing this library. */
#    define ELEVEN_EXPORT __declspec(dllimport)
#  endif
#endif

namespace eleven {

ELEVEN_EXPORT unsigned int eleven();

}

#endif

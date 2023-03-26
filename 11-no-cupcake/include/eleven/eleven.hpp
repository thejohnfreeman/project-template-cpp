#ifndef ELEVEN_HPP
#define ELEVEN_HPP

#ifdef WIN32
#  ifdef ELEVEN_STATIC
#    define ELEVEN_EXPORT
#  elif ELEVEN_EXPORTS
     /* We are building this library. */
#    define ELEVEN_EXPORT __declspec(dllexport)
#  else
     /* We are importing this library. */
#    define ELEVEN_EXPORT __declspec(dllimport)
#  endif
#else
#  define ELEVEN_EXPORT
#endif

namespace eleven {

ELEVEN_EXPORT unsigned int eleven();

}

#endif

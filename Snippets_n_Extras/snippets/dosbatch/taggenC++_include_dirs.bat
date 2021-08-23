@ECHO OFF
REM Run this batch file into the directory which contains
REM extension-less C++ header files from the compiler, e.g., iostream
@ECHO ON
ctags --sort=yes --language-force=C++ --c-kinds=+pxvtcdeglmnsu-f --c++-kinds=+pxvtcdeglmnsu-f --languages=C,C++ --langmap=C:.h. --langmap=C++:+.tcc..H.h.hpp.h++.hh.hp.hxx. --fields=+iaSmz --extra=+qf -I "_GLIBCXX_BEGIN_NAMESPACE_VERSION _GLIBCXX_END_NAMESPACE_VERSION _GLIBCXX_VISIBILITY+" -f tags *
cmd

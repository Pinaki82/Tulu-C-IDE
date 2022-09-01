@ECHO OFF
REM https://www.tutorialspoint.com/unix_commands/ctags.htm
REM ctags --list-kinds
REM ctags --list-fields
REM ctags --list-extras

REM Ctags will generate tags DB only for function parameters and
REM header file names. Use the old command set if you need a
REM more comprehensive tags database for some reason.

REM Old: ctags -R --sort=yes --c-kinds=+pxfvtdeglmsu --c++-kinds=+pxfvtcdeglmnsu --languages=C,C++ --langmap=C:.c.h.ino.pde --langmap=C++:+.tcc..C.h.c.cpp.hpp.c++.cc.cp.cxx.h++.hh.hp.hxx.ino.pde --fields=+iaSmz --extras=+qf -f tags * 
@ECHO ON

ctags -R --sort=yes --c-kinds=+pxfvtdeglmsu --c++-kinds=+pxfvtcdeglmnsu --languages=C,C++ --langmap=C:.c.h.ino.pde --langmap=C++:+.tcc..C.h.c.cpp.hpp.c++.cc.cp.cxx.h++.hh.hp.hxx.ino.pde --fields=+iaSmz --extras=+qf -f tags *
cmd

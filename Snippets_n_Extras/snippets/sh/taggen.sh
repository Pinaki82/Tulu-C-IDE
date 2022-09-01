#!/bin/bash

# https://www.tutorialspoint.com/unix_commands/ctags.htm
# ctags --list-kinds
# ctags --list-fields
# ctags --list-extras

# Ctags will generate tags DB only for function parameters and
# header file names. Use the old command set if you need a
# more comprehensive tags database for some reason.

# Old: ctags -R --sort=yes --c-kinds=+pxfvtdeglmsu --c++-kinds=+pxfvtcdeglmnsu --languages=C,C++ --langmap=C:.c.h.ino.pde --langmap=C++:+.tcc..C.h.c.cpp.hpp.c++.cc.cp.cxx.h++.hh.hp.hxx.ino.pde --fields=+iaSmz --extras=+qf -f tags * 

ctags -R --sort=yes --c-kinds=+pfhd --c++-kinds=+pfhd --languages=C,C++ --langmap=C:.c.h.ino.pde --langmap=C++:+.tcc..C.h.c.cpp.hpp.c++.cc.cp.cxx.h++.hh.hp.hxx.ino.pde --fields=+lSmz --extras=+f -f tags * 

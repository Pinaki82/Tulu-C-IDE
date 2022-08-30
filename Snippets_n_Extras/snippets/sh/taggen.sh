#!/bin/bash

ctags -R --sort=yes --c-kinds=+pxfvtdeglmsu --c++-kinds=+pxfvtcdeglmnsu --languages=C,C++ --langmap=C:.c.h.ino.pde --langmap=C++:+.tcc..C.h.c.cpp.hpp.c++.cc.cp.cxx.h++.hh.hp.hxx.ino.pde --fields=+iaSmz --extras=+qf -f tags * 

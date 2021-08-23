@echo on
cd
cls
astyle -A2 -s2 -C -S -K -N -L -w -Y -m1 -U -y -j -o -c -k3 -W3 --mode=c -R -v -z1  *.c *.h
cmd

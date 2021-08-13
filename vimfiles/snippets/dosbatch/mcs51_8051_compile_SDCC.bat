cd
cls
rem --noinduction --opt-code-size --opt-code-speed --std-sdcc89
rem cancel loop-optimization, optimization of code for size, optimization of code for speed
rem code, iram, xram sizes are written in byte, generally convert KB to byte
cls
sdcc -mmcs51 --iram-size 256 --xram-size 0 --code-size 8192  --nooverlay --verbose --debug -V --model-small -I"C:\Program Files\SDCC\include" -c  "my_program.c" -o "my_program.rel"
sdcc.exe -L"C:\Program Files\SDCC\lib" -o "my_program.ihx" -mmcs51 --model-small --debug --out-fmt-ihx "C:\Program Files\SDCC\lib\small\mcs51.lib" "my_program.rel"
packihx "my_program.ihx" > "my_program.hex"
cmd


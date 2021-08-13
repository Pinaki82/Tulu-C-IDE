avrdude -c stk500v1 -p m328 -P COM3 -b 19200 -U lfuse:w:0xFF:m -U hfuse:w:0xDE:m -U efuse:w:0x05:m

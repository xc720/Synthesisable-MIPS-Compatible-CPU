mips-linux-gnu-as -o as.out addiu2.asm
mips-linux-gnu-readelf --hex-dump=.text as.out | sed -n -e '/0x00000000/,$p' | sed 's/^ *0x//g' | xxd -r | xxd -p -c 10000000000 | sed 's/.\{8\}/& /g' > as.dump
iverilog -Wall -g 2012 -o tb *.v  && ./tb
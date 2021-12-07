#!/bin/bash
set -eou pipefail
red=`tput setaf 1`
green=`tput setaf 2`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`



cd /home/domjustice/projects/second_qlab/MIPS_SYSTEM_VERILOG/test/testbench_and_RAM
mips-linux-gnu-as --no-warn -o as.out ../assembler/assembly/addiu2.asm
mips-linux-gnu-readelf --hex-dump=.text as.out | sed -n -e '/0x00000000/,$p' | sed 's/^ *0x//g' | xxd -r | xxd -p -c 10000000000 | sed 's/.\{8\}/& /g' > as.dump
rm as.out
echo -e "${red}addiu2.asm  \t ${green}Done"

echo -e "\n${magenta}Conversion Complete"

iverilog -Wall -g 2012 -o tb.out ../../rtl/*.v mips_cpu_*.v && ./tb.out


if cmp --silent -- "result.txt" "../assembler/results/addiu2.txt"; then
  echo "TEST PASSED"
else
  echo "TEST FAILED"
fi
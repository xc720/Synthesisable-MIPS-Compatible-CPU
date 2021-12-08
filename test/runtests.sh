#!/bin/bash
set -eou pipefail
red=`tput setaf 1`
green=`tput setaf 2`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`
mkdir ./testbench_and_RAM/compiled_results
mkdir ./assembler/hexadecimal
cd assembler/assembly
echo
echo -e "${magenta}INSTRUCTION TESTING"
echo
declare -i passed=0
declare -i failed=0
for f in *.asm; do
    cd ../hexadecimal
    mips-linux-gnu-as --no-warn -o $f.out ../assembly/$f
    mips-linux-gnu-readelf --hex-dump=.text $f.out | sed -n -e '/0x00000000/,$p' | sed 's/^ *0x//g' | xxd -r | xxd -p -c 10000000000 | sed 's/.\{8\}/& /g' > $f.txt
    rm $f.out
    cd ../../testbench_and_RAM
    iverilog -Wall -g 2012 -o tb.out ../../rtl/*.v mips_cpu_*.v -P mips_cpu_bus_tb.RAM_INIT_FILE=\"../assembler/hexadecimal/$f.txt\" >/dev/null && ./tb.out >/dev/null || true
    rm tb.out
    cd compiled_results
    sed -i "s/ //g" result.txt
    mv result.txt $f.result.txt
    declare -i spaces=16
    declare -i size=${#f}
    declare -i diff=(spaces-size)
    if cmp --silent -- $f.result.txt ../../assembler/results/$f.result.txt; then
      #echo -e "${reset}$f\t${blue}-->\t${green}PASSED"
      printf "${reset}"
      printf "$f"
      printf "%-${diff}s" " " 
      printf "${blue}-->\t${green}PASSED\n"
      passed=passed+1
    else
      printf "${reset}"
      printf "$f"
      printf "%-${diff}s" " " 
      printf "${blue}-->\t${red}FAILED\n"
      failed=failed+1
    fi
    cd ../../assembler/assembly
done
rm -r ../hexadecimal
rm -r ../../testbench_and_RAM/compiled_results

echo
echo "${green}Tests passed:   $passed"
echo "${red}Tests failed:   $failed"
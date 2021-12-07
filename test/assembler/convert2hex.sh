#!/bin/bash
set -eou pipefail
red=`tput setaf 1`
green=`tput setaf 2`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`

cd assembly
for f in *.asm; do
    cd ../hexadecimal
    mips-linux-gnu-as --no-warn -o $f.out ../assembly/$f
    mips-linux-gnu-readelf --hex-dump=.text $f.out | sed -n -e '/0x00000000/,$p' | sed 's/^ *0x//g' | xxd -r | xxd -p -c 10000000000 | sed 's/.\{8\}/& /g' > $f.txt
    rm $f.out
    echo -e "${red}$f  \t ${green}Done"
done
echo -e "\n${magenta}Conversion Complete"
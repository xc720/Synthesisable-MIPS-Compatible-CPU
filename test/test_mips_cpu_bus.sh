#!/bin/bash
set -eou pipefail
red=`tput setaf 1`
green=`tput setaf 2`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`
#mkdir ./test/testbench_and_RAM/compiled_results
#mkdir ./test/assembler/hexadecimal

RTLDR=$1
INSTRCTN=${2:-all}
if [ ! -d $1 ]; then
  echo -e "Invalid RTL Dir: $1"
  exit
fi
cd test/assembler/assembly
echo
echo "${red}-=-=-=-=-=-=-=-=-=-"
echo -e "${blue}INSTRUCTION TESTING"
echo "${red}-=-=-=-=-=-=-=-=-=-"
if [ "$INSTRCTN" != "all" ]; then
  printf "Instruction: ${magenta}"
  input_instruction=$2
  echo -e "\n${reset}Testing ${magenta}${input_instruction^^}\n"
elif [ "$INSTRCTN" = "all" ]; then
  echo -e "\nTesting ${magenta}ALL\n"
fi
echo "${reset}================================================================="
echo -e "${red}INSTRUCTION${reset}\t|\t${red}VARIANT${reset}\t    |  ${red}EXEC TIME${reset}\t|  ${red}RESULT${reset}"

declare -i passed=0
declare -i failed=0
declare previous_instruction="s"

for f in *.asm; do
  declare instruction=$(echo ${f::-6} | tr '[:lower:]' '[:upper:]')
  if [ "$INSTRCTN" = "all" ]; then
    instruction=$(echo ${f::-6} | tr '[:lower:]' '[:upper:]')
  elif [ "$INSTRCTN" != "all" ]; then
    if [ "$instruction" = "${input_instruction^^}" ]; then
      instruction=$(echo ${f::-6} | tr '[:lower:]' '[:upper:]')
    else
      continue
    fi
  fi
  declare instruction_print=""
  cd ../hexadecimal
  mips-linux-gnu-as --no-warn -o $f.out ../assembly/$f
  mips-linux-gnu-readelf --hex-dump=.text $f.out | sed -n -e '/0x00000000/,$p' | sed 's/^ *0x//g' | xxd -r | xxd -p -c 10000000000 | sed 's/.\{8\}/& /g' > $f.txt
  rm $f.out
  cd ../../testbench_and_RAM
  start=$(date +%s.%N)
  iverilog -Wall -g 2012 -o tb.out $RTLDR/*.v mips_cpu_*.v -P mips_cpu_bus_tb.RAM_INIT_FILE=\"../assembler/hexadecimal/$f.txt\" >/dev/null && ./tb.out >/dev/null || true
  dur=$(echo "$(date +%s.%N) - $start" | bc)
  rm tb.out
  cd compiled_results
  sed -i "s/ //g" result.txt
  mv result.txt $f.result.txt
  declare -i spaces=16
  declare -i size=${#f}
  declare -i diff=(spaces-size)
  if [ "$instruction" = "$previous_instruction" ]; then
    instruction_print="    "
  else
    instruction_print=$instruction
    echo "${reset}================================================================="
  fi

  if cmp --silent -- $f.result.txt ../../assembler/results/$f.result.txt; then
    #echo -e "${reset}$f\t${blue}-->\t${green}PASSED"
    printf "${reset}"
    printf "${magenta}$instruction_print${reset}"
    printf "%-${diff}s" " " 
    printf "\t|\t${blue}${f%.*}${reset}"
    printf "%-${diff}s" " " 
    printf "|  ${reset}%.6fs\t|  ${green}PASSED\n" $dur
    passed=passed+1
  else
    printf "${reset}"
    printf "${magenta}$instruction_print${reset}"
    printf "%-${diff}s" " " 
    printf "\t|\t${blue}${f%.*}${reset}"
    printf "%-${diff}s" " " 
    printf "|  ${reset}%.6fs\t|  ${red}FAILED\n" $dur
    failed=failed+1
  fi
  cd ../../assembler/assembly
  previous_instruction=$instruction
done
#rm -r ../hexadecimal
#rm -r ../../testbench_and_RAM/compiled_results

echo
echo "${green}Tests passed:   $passed"
echo "${red}Tests failed:   $failed"
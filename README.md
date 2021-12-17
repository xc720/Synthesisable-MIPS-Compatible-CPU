## Synthesisable MIPS-Compatible CPU
This CPU implements a subset of the MIPS IV ISA revision 3.2 and operates using 32, 32-bit registers,  following the basic principles of a bus architecture (instructions and data share the same interface to the CPU). As shown in the top-level diagram below, core components of the CPU are the ALU, controller, instruction register,program counter, register file.

![Top-level diagram](docs/top-level-diagram.png)

As per the specification, the CPU uses the Intel Avalon memory mapping interface, allowing for a more accessible solution. We use a 32 bit, big endian system and there is no support for double word instructions or instructions involving floating point numbers.

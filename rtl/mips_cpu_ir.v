module instruction_register( //copy and pasted the top part
    input logic clk,
    input logic enable,
    input logic state,
    /*open the register in right state*/
    input logic[31:0] memory_output,
    /*input instruction from memory*/
    
    output logic[5:0] control_input,
    /*opcode for control module*/
    output logic[4:0] source_1,
    /*address for first register*/
    output logic[4:0] source_2,
    /*address for second register*/
    output logic[4:0] dest,
    /*address for destnation regsiter*/
    output logic[15:0] immediate,
    /*16 bits immediate constant*/
    output logic[25:0] jmp_address,
    /*memory address for J-type instruction*/
    output logic [5:0] funct
    /*function code*/
);

    
endmodule 
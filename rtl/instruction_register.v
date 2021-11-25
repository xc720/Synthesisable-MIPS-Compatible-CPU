`timescale 1ns/100ps

module instruction_register(
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

    always @(posedge clk) begin
        if (enable == 1 || state == 0) begin
        /*assume we open instruction register in state 0 */
            control_input = memory_output[31:26];
            source_1 = memory_output[25:21];
            source_2 = memory_output[20:16];
            dest = memory_output[15:11];
            immediate = memory_output[15:0];
            jmp_address = memory_output[25:0];
            funct = memory_output[5:0];
        end
    end


endmodule
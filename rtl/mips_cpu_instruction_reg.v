module mips_cpu_instruction_reg (
    input logic clk,
    input logic enable,
    input logic [2:0] state,
    /*open the register in right state*/
    input logic [31:0] memory_output,
    /*input instruction from memory*/

    output logic [ 5:0] control_input,
    /*opcode for control module*/
    output logic [ 4:0] source_1,
    /*address for first register*/
    output logic [ 4:0] source_2,
    /*address for second register*/
    output logic [ 4:0] dest,
    /*address for destnation regsiter*/
    output logic [15:0] immediate,
    /*16 bits immediate constant*/
    output logic [25:0] jmp_address,
    /*memory address for J-type instruction*/
    output logic [ 5:0] funct,
    /*function code*/
    output logic [ 4:0] shamt
    /*shift for alu*/
);

  logic [31:0] instruction;

  logic [31:0] instructiondecode;

  assign instructiondecode = memory_output;

  always_ff @(posedge clk) begin
    if (enable == 1 || state == 0) begin
      /*assume we open instruction register in state 0 */
      instruction <= memory_output;
    end
  end

  assign control_input = state == 2 ? instructiondecode[31:26] : instruction[31:26];
  assign source_1 = state == 2 ? instructiondecode[25:21] : instruction[25:21];
  assign source_2 = state == 2 ? instructiondecode[20:16] : instruction[20:16];
  assign dest = state == 2 ? instructiondecode[15:11] : instruction[15:11];
  assign immediate = state == 2 ? instructiondecode[15:0] : instruction[15:0];
  assign jmp_address = state == 2 ? instructiondecode[25:0] : instruction[25:0];
  assign funct = state == 2 ? instructiondecode[5:0] : instruction[5:0];
  assign shamt = state == 2 ? instructiondecode[10:6] : instruction[10:6];


endmodule

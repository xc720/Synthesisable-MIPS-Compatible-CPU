module mips_cpu_alu (
    //input logic[5:0] opcode,
    input logic [4:0] alu_func,
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [4:0] shift,
    output logic [31:0] result,
    output logic condition
);


  always_comb begin
    case (alu_func)
      5'b00000:
      result = $unsigned(a) + $unsigned(b);  // ADDU  (immediate or not determined elsewhere)
      5'b00001: result = a & b;  // AND
      5'b00010: result = a | b;  // OR
      5'b00011: result = $unsigned(a) - $unsigned(b);  // SUBU
      5'b00100: result = $signed(a) < $signed(b);  // SLT
      5'b00101: result = $unsigned(a) < $unsigned(b);  // SLTU
      5'b00110: result = (a << shift);  // SLL
      5'b00111: result = a << b;  // SLLV
      5'b01000: result = a >> shift;  // SRL
      5'b01001: result = a >> b;  // SRLV
      5'b01010: result = $signed(a) >>> shift;  // SRA
      5'b01011: result = $signed(a) >>> b;  // SRAV
      5'b01100: result = a ^ b;  // XOR

      //branch conditions
      5'b01100: result = (a == b);  // BEQ
      5'b01101: result = $signed(a) >= 0;  // BGEZ (and link?)
      5'b01110: result = $signed(a) > 0;  // BGTZ
      5'b01111: result = $signed(a) <= 0;  // BLEZ
      5'b10000: result = $signed(a) < 0;  // BLTZ (and link?)
      5'b10001: result = (a != b);  // BNE
      default:  result = 0;
    endcase
  end


  assign condition = (result == 0);

endmodule

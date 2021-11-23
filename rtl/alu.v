module ALU(
  input logic[5:0] opcode,
  input logic[4:0] funct,
  input logic[31:0] a,
  input logic[31:0] b,
  input logic[4:0] shift,
  output logic[31:0] result,
  output logic zero
);

always_comb begin 
  case(funct)
    4'b0000 : result = $unsigned(a) + $unsigned(b); // ADDU  (immediate or not determined elsewhere)
    4'b0001 : result = a & b; // AND
    4'b0010 : result = a || b; // OR
    4'b0011 : result = $unsigned(a) - $unsigned(b); // SUBU
    4'b0100 : result = $signed(a) < $signed(b); // SLT
    4'b0101 : result = $unsigned(a) < $unsigned(b); // SLTU
    4'b0110 : result = a << shift; // SLL
    4'b0111 : result = a << b; // SLLV
    4'b1000 : result = a >> shift; // SRL
    4'b1001 : result = a >> b; // SRLV
    4'b1010 : result = a >>> shift; // SRA
    4'b1011 : result = a >>> b; // SRAV
    default : result = 0;
  endcase
end


assign zero = (result == 0);

endmodule

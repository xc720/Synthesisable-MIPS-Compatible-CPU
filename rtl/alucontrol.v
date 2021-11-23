module aluControl(
    input logic[2:0] aluOp,
    input logic[5:0] funct,
    output logic[4:0] toAlu
);
    always_comb begin 
        case(aluOp)
            2'b00 : toAlu = 0000; // add
            2'b01 : toAlu = 0011; // subtract
            2'b10 : case(funct)
                        6'b100000 : toAlu = 0000; // add unsigned
                        6'b100100 : toAlu = 0001; // AND
                        6'b100101 : toAlu = 0010; // OR
                        6'b101010 : toAlu = 0100; // SLT
                        6'b101011 : toAlu = 0101; // SLTU
                        6'b000000 : toAlu = 0110; // SLL
                        6'b000100 : toAlu = 0111; // SLLV
                        6'b000010 : toAlu = 1000; // SRL
                        6'b000110 : toAlu = 1001; // SRLV
                        6'b000011 : toAlu = 1010; // SRA
                        6'b000111 : toAlu = 1011; //SRAV
                        6'b100011  : toAlu = 0011; //SUBU
                    endcase
        endcase
    end
endmodule

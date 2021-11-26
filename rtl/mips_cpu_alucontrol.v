module aluControl(
    input logic[3:0] aluOp,
    input logic[5:0] funct,
    output logic[4:0] toAlu
);
    always_comb begin 
        case(aluOp)
            4'b0000 : toAlu = 5'b00000; // add
            4'b0001 : toAlu = 5'b00011; // subtract
            4'b0010 : case(funct)
                        6'b100000 : toAlu = 5'b00000; // add unsigned
                        6'b100100 : toAlu = 5'b00001; // AND
                        6'b100101 : toAlu = 5'b00010; // OR
                        6'b101010 : toAlu = 5'b00100; // SLT
                        6'b101011 : toAlu = 5'b00101; // SLTU
                        6'b000000 : toAlu = 5'b00110; // SLL
                        6'b000100 : toAlu = 5'b00111; // SLLV
                        6'b000010 : toAlu = 5'b01000; // SRL
                        6'b000110 : toAlu = 5'b01001; // SRLV
                        6'b000011 : toAlu = 5'b01010; // SRA
                        6'b000111 : toAlu = 5'b01011; //SRAV
                        6'b100011 : toAlu = 5'b00011; //SUBU
                    endcase

            4'b0011 : toAlu = 5'b01100; //  BEQ
            4'b0100 : toAlu = 5'b01101; // BGEZ
            4'b0101 : toAlu = 5'b01110; // BGTZ
            4'b0110 : toAlu = 5'b01111; // BLEZ
            4'b0111 : toAlu = 5'b10000; // BLTZ
            4'b1000 : toAlu = 5'b10001; // BNE
            default: toAlu  = 5'b00000;
        endcase
    end
endmodule

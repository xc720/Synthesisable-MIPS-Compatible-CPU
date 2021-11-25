//the mux which is used to determine what address is used for the memory
module IorD (
    input logic [31:0] pc_out,
    input logic [31:0] ALUout,
    input logic control_signal,
    output logic [31:0] memory_address
);

  assign memory_address = (control_signal ? ALUout : pc_out);


endmodule

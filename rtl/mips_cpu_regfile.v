module mips_register_file (
    // control ports
    input logic clk,
    input logic reset,
    input logic write_enable,
    // dual input read ports & write input ports
    input logic [4:0] read_reg_1,
    input logic [4:0] read_reg_2,
    input logic [4:0] write_reg,
    input logic [31:0] write_data,
    // dual read output ports & v0 port
    output logic [31:0] read_data_1,
    output logic [31:0] read_data_2,
    output logic [31:0] read_data_v0

);


endmodule
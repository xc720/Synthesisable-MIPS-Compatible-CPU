`timescale 1ns / 100ps
module mips_cpu_register_file (
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
  // create 32x32-bit register
  logic [31:0] register[31:0];
  
  // return data
  assign read_data_v0 = register[2];
  assign read_data_1  = register[read_reg_1];
  assign read_data_2  = register[read_reg_2];

  // reset & write
  always_ff @(posedge clk) begin
    // reset register
    if (reset) begin
      for (int i = 0; i < 32; i++) register[i] <= 0;
    end
        // write to register
        else
    begin
      if (write_enable & write_reg != 0) begin
        register[write_reg] <= write_data;
        $display("[WRITE EVENT]\tREG%d\t<-%d", write_reg, write_data);
      end
    end
  end

endmodule

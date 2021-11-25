module pc_source(
   input logic [1:0] control_signal
);

pc pc_0 (
    .clk(clk),
    .reset(reset),
    .pc_in(pc_in),
    .pc_write(pc_write),
    .pc_out(pc_out)
);
endmodule